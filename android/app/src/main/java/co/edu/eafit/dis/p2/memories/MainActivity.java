package co.edu.eafit.dis.p2.memories;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.speech.tts.TextToSpeech;
import android.util.Log;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;

import java.util.Locale;
import java.util.StringTokenizer;
import java.util.concurrent.ExecutionException;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import okhttp3.Call;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import com.spotify.sdk.android.authentication.AuthenticationClient;
import com.spotify.sdk.android.authentication.AuthenticationRequest;
import com.spotify.sdk.android.authentication.AuthenticationResponse;
import com.spotify.sdk.android.player.Config;
import com.spotify.sdk.android.player.ConnectionStateCallback;
import com.spotify.sdk.android.player.Connectivity;
import com.spotify.sdk.android.player.Error;
import com.spotify.sdk.android.player.Metadata;
import com.spotify.sdk.android.player.PlaybackBitrate;
import com.spotify.sdk.android.player.PlaybackState;
import com.spotify.sdk.android.player.Player;
import com.spotify.sdk.android.player.PlayerEvent;
import com.spotify.sdk.android.player.Spotify;
import com.spotify.sdk.android.player.SpotifyPlayer;


public class MainActivity extends FlutterActivity implements TextToSpeech.OnInitListener, Player.NotificationCallback, ConnectionStateCallback {

    //   ____                _              _
    //  / ___|___  _ __  ___| |_ __ _ _ __ | |_ ___
    // | |   / _ \| '_ \/ __| __/ _` | '_ \| __/ __|
    // | |__| (_) | | | \__ \ || (_| | | | | |_\__ \
    //  \____\___/|_| |_|___/\__\__,_|_| |_|\__|___/
    //

    @SuppressWarnings("SpellCheckingInspection")
    private static final String CLIENT_ID = "207df83d2d834274b4f3c7b16f7556f1";
    @SuppressWarnings("SpellCheckingInspection")
    private static final String REDIRECT_URI = "memories://callback";

    private static final int REQUEST_CODE = 1337;


    private String TOKEN = "";

    public String  SPOTIFY_URI = "spotify:user:spotify:playlist:37i9dQZF1DXcCT9tm6fRIV";

    private SpotifyPlayer mPlayer;

    private String actualSong = "";
    private long duration = 180000;
    private SharedPreferences sharedPref;

    private PlaybackState mCurrentPlaybackState;


    SharedPreferences.Editor editor;

    private Metadata mMetadata;

    private final Player.OperationCallback mOperationCallback = new Player.OperationCallback() {
        @Override
        public void onSuccess() {
            Log.d("Spotify", "OK!");
            if (mMetadata.currentTrack != null) {
                actualSong = "";
                actualSong += mMetadata.currentTrack.name + ",";
                actualSong += mMetadata.currentTrack.artistName + ",";
                actualSong += mMetadata.currentTrack.albumCoverWebUrl + ",";
                duration = mMetadata.currentTrack.durationMs;
            }

        }

        @Override
        public void onError(Error error) {
            Log.d("Spotify", "ERROR:" + error);
        }
    };


    private Connectivity getNetworkConnectivity(Context context) {
        try {
            ConnectivityManager connectivityManager;
            connectivityManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo activeNetwork = connectivityManager.getActiveNetworkInfo();
            if (activeNetwork != null && activeNetwork.isConnected()) {
                return Connectivity.fromNetworkType(activeNetwork.getType());
            } else {
                return Connectivity.OFFLINE;
            }
        } catch (NullPointerException e) {
            Log.d("ERR", e.getMessage());
            return Connectivity.OFFLINE;
        }
    }

    private void openLoginWindow() {
        final AuthenticationRequest request = new AuthenticationRequest.Builder(CLIENT_ID, AuthenticationResponse.Type.TOKEN, REDIRECT_URI)
                .setScopes(new String[]{"user-read-private", "playlist-read", "playlist-read-private", "streaming"})
                .build();

        AuthenticationClient.openLoginActivity(this, REQUEST_CODE, request);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);

        // Check if result comes from the correct activity
        if (requestCode == REQUEST_CODE) {
            AuthenticationResponse response = AuthenticationClient.getResponse(resultCode, intent);
            switch (response.getType()) {
                // Response was successful and contains auth token
                case TOKEN:
                    onAuthenticationComplete(response);
                    break;

                // Auth flow returned an error
                case ERROR:
                    Log.d("Spotify", "Auth error: " + response.getError());
                    break;

                // Most likely auth flow was cancelled
                default:
                    Log.d("Spotify", "Auth result: " + response.getType());
            }
        }
    }

    private void onAuthenticationComplete(AuthenticationResponse authResponse) {
        // Once we have obtained an authorization token, we can proceed with creating a Player.
        Log.d("Spotify", "Got authentication token");
        if (mPlayer == null) {
            Config playerConfig = new Config(getApplicationContext(), authResponse.getAccessToken(), CLIENT_ID);
            editor.putString("token", authResponse.getAccessToken());
            editor.commit();
            TOKEN = authResponse.getAccessToken();
            // Since the Player is a static singleton owned by the Spotify class, we pass "this" as
            // the second argument in order to refcount it properly. Note that the method
            // Spotify.destroyPlayer() also takes an Object argument, which must be the same as the
            // one passed in here. If you pass different instances to Spotify.getPlayer() and
            // Spotify.destroyPlayer(), that will definitely result in resource leaks.
            mPlayer = Spotify.getPlayer(playerConfig, this, new SpotifyPlayer.InitializationObserver() {
                @Override
                public void onInitialized(SpotifyPlayer player) {
                    Log.d("Spotify", "-- Player initialized --");

                    mPlayer.setPlaybackBitrate(mOperationCallback, PlaybackBitrate.BITRATE_HIGH);
                    mPlayer.setConnectivityStatus(mOperationCallback, getNetworkConnectivity(MainActivity.this));
                    mPlayer.setShuffle(mOperationCallback,true);
                    mPlayer.addNotificationCallback(MainActivity.this);
                    mPlayer.addConnectionStateCallback(MainActivity.this);
                }

                @Override
                public void onError(Throwable error) {
                    Log.d("Spotify", "Error in initialization: " + error.getMessage());
                }
            });
        } else {
            mPlayer.login(authResponse.getAccessToken());
        }
    }

    @Override
    public void onLoggedIn() {
        Log.d("Spotify", "Login complete");
    }

    @Override
    public void onLoggedOut() {
        Log.d("Spotify", "Logout complete");
    }

    public void onLoginFailed(Error error) {
        Log.d("Spotify", "Login error " + error);
    }

    @Override
    public void onTemporaryError() {
        Log.d("Spotify", "Temporary error occurred");
    }

    @Override
    public void onConnectionMessage(final String message) {
        Log.d("Spotify", "Incoming connection message: " + message);
    }

    @Override
    protected void onPause() {
        super.onPause();
        //unregisterReceiver(mNetworkStateReceiver);

        // Note that calling Spotify.destroyPlayer() will also remove any callbacks on whatever
        // instance was passed as the refcounted owner. So in the case of this particular example,
        // it's not strictly necessary to call these methods, however it is generally good practice
        // and also will prevent your application from doing extra work in the background when
        // paused.
        if (mPlayer != null) {
            mPlayer.removeNotificationCallback(MainActivity.this);
            mPlayer.removeConnectionStateCallback(MainActivity.this);
        }
    }

    @Override
    protected void onDestroy() {
        // *** ULTRA-IMPORTANT ***
        // ALWAYS call this in your onDestroy() method, otherwise you will leak native resources!
        // This is an unfortunate necessity due to the different memory management models of
        // Java's garbage collector and C++ RAII.
        // For more information, see the documentation on Spotify.destroyPlayer().
        Spotify.destroyPlayer(this);
        super.onDestroy();
    }

    @Override
    public void onPlaybackEvent(PlayerEvent event) {
        // Remember kids, always use the English locale when changing case for non-UI strings!
        // Otherwise you'll end up with mysterious errors when running in the Turkish locale.
        // See: http://java.sys-con.com/node/46241
        Log.d("Spotify", "Event: " + event);
        mCurrentPlaybackState = mPlayer.getPlaybackState();
        mMetadata = mPlayer.getMetadata();
        Log.d("Spotify", "Player state: " + mCurrentPlaybackState);
        Log.d("Spotify", "Metadata Marico: " + mMetadata);
        if (mMetadata.currentTrack != null) {
            actualSong = "";
            actualSong += mMetadata.currentTrack.name + ",";
            actualSong += mMetadata.currentTrack.artistName + ",";
            actualSong += mMetadata.currentTrack.albumCoverWebUrl + ",";
        }

    }

    public void login() {
        Log.d("Spotify", "Logging in");
        openLoginWindow();
    }

    public void play() {
        Log.d("Spotify", "La que hay in");
        mPlayer.playUri(mOperationCallback, SPOTIFY_URI, 0, 0);
        Log.d("Spotify", mPlayer.getMetadata().toString());
    }

    public void resume() {
        Log.d("Spotify", "La que hay in");
        mPlayer.resume(mOperationCallback);
        Log.d("Spotify", mPlayer.getMetadata().toString());
    }

    public void next() {
        mPlayer.skipToNext(mOperationCallback);

    }

    public void prev() {
        mPlayer.skipToPrevious(mOperationCallback);
    }

    public void stop() {
        mPlayer.pause(mOperationCallback);
    }

    @Override
    public void onPlaybackError(Error error) {
        Log.d("Spotify", "Err: " + error);
    }


    private TextToSpeech myTTS;
    /**
     * Plugin registration.
     */

    private static final String CHANNEL = "co.edu.eafit.dis.p2.memories";
    Locale locSpanish = new Locale("spa", "CO");

    @Override
    public void onCreate(Bundle savedInstanceState) {
        sharedPref = this.getPreferences(Context.MODE_PRIVATE);
        editor = sharedPref.edit();
        super.onCreate(savedInstanceState);
        myTTS = new TextToSpeech(this, this);
        myTTS.setLanguage(locSpanish);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        switch (call.method) {
                            case "sendEmotion":
                                String a = sendEmotion((String) call.argument("path"));
                                result.success(a);

                                break;
                            case "speak":
                                String text = call.argument("text");
                                speak(text);
                                break;
                            case "isLanguageAvailable": {
                                String language = call.argument("language");
                                final Boolean isAvailable = isLanguageAvailable(language);
                                result.success(isAvailable);
                                break;
                            }
                            case "setLanguage": {
                                String language = call.argument("language");
                                final Boolean success = setLanguage(language);
                                result.success(success);
                                break;
                            }
                            case "flush": {
                                flush();
                                break;
                            }
                            case "distraccion": {
                                play();
                                result.success(duration);
                                break;
                            }
                            case "finDistraccion": {
                                stop();
                                result.success("success");
                                break;
                            }
                            case "spotifyLogin":
                                SPOTIFY_URI = call.argument("uri");
                                login();
                                result.success(TOKEN);
                                break;
                            case "spotifyPlay":
                                Boolean isPlaying = call.argument("isFirstPlay");
                                if (isPlaying) {
                                    play();
                                } else {
                                    resume();
                                }
                                if (!actualSong.equals("")) {
                                    result.success(actualSong);
                                } else {
                                    if (mMetadata.currentTrack != null) {
                                        actualSong = "";
                                        actualSong += mMetadata.currentTrack.name + ",";
                                        actualSong += mMetadata.currentTrack.artistName + ",";
                                        actualSong += mMetadata.currentTrack.albumCoverWebUrl + ",";
                                    } else {
                                        actualSong = "---,---,http://backgroundcheckall.com/wp-content/uploads/2017/12/spotify-logo-transparent-background-1.png";
                                    }
                                }
                                actualSong = "";
                                break;
                            case "spotifyNext":
                                next();
                                result.success(actualSong);
                                actualSong = "";
                                break;
                            case "spotifyPrev":
                                prev();
                                result.success(actualSong);
                                actualSong = "";
                                break;
                            case "spotifyPause":
                                stop();
                                result.success("");
                                break;
                            case "spotifyGetToken":
                                result.success(TOKEN);
                                break;
                            default:
                                result.notImplemented();
                                break;
                        }
                    }
                });
    }


    public void onInit(int initStatus) {
        if (initStatus == TextToSpeech.ERROR) {
        }
    }

    void speak(String text) {
        myTTS.speak(text, TextToSpeech.QUEUE_ADD, null, null);
    }

    void flush() {
        if(myTTS.isSpeaking()){
            myTTS.stop();
        }
    }

    Boolean isLanguageAvailable(String locale) {
        Boolean isAvailable = false;
        try {
            isAvailable = myTTS.isLanguageAvailable(stringToLocale(locale)) == TextToSpeech.LANG_COUNTRY_AVAILABLE;
        } finally {
            return isAvailable;
        }
    }

    Boolean setLanguage(String locale) {
        Boolean success = false;
        try {
            myTTS.setLanguage(stringToLocale(locale));
            success = true;
        } finally {
            return success;
        }

    }

    private Locale stringToLocale(String locale) {
        String l = null;
        String c = null;
        StringTokenizer tempStringTokenizer = new StringTokenizer(locale, "-");
        if (tempStringTokenizer.hasMoreTokens()) {
            l = tempStringTokenizer.nextElement().toString();
        }
        if (tempStringTokenizer.hasMoreTokens()) {
            c = tempStringTokenizer.nextElement().toString();
        }
        return new Locale(l, c);
    }


    private String sendEmotion(String path) {
        return(getEmotion(path));
    }

    public static byte[] toBase64(String filePath) {

        File imgFile = new File(filePath);
        if (imgFile.exists()) {
            Bitmap bm = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            bm.compress(Bitmap.CompressFormat.JPEG, 100, baos);
            return baos.toByteArray();
        }
        Log.e("Base 64 Error", " toBase64 error");
        return null;

    }

    public String getEmotion(String path) {
        // run the GetEmotionCall class in the background
        GetEmotionCall emotionCall = new GetEmotionCall(path);
        try {
            String a;
             new Thread(
                     a = emotionCall.execute().get()
             ).start();
            Log.d("CONO",a);
            return a;
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            Log.d("AQUI NO", "SHUT UP");
            return "NOO";
        }
    }


    private static class GetEmotionCall extends AsyncTask<Void, Void, String> {
        private String path;

        GetEmotionCall(String path) {
            this.path = path;
        }

        @Override
        protected void onPreExecute() {
            super.onPreExecute();

        }

        @Override
        protected String doInBackground(Void... params) {
            String res = "que pajo";
            try {
                //URIBuilder builder = new URIBuilder("https://eastus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion");
                OkHttpClient httpClient = new OkHttpClient();
                RequestBody requestBody = RequestBody.create(MediaType.parse("application/octet-stream"), new File(path));

                Request request = new Request.Builder()
                        .url("https://eastus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion")
                        .addHeader("Ocp-Apim-Subscription-Key", "0f9ebeaedb9f495c80fde9a845241dc1")
                        .addHeader("Content-Type", "application/octet-stream")
                        .post(requestBody)
                        .build();
                Log.e("Request", request.toString());
                Call call = httpClient.newCall(request);
                Response response = call.execute();
                res = response.body().string();
                Log.e("APIII", response.body().string());
                return response.body().string();

            } catch (Exception e) {
                return res;
            }

        }

        @Override
        protected void onPostExecute(String result) {

            JSONArray jsonArray = null;
            try {
                jsonArray = new JSONArray(result);
                String emotions = "";
                for (int i = 0; i < jsonArray.length() - 1; i++) {
                    JSONObject jsonObject = new JSONObject(jsonArray.get(i).toString());
                    JSONObject scores = jsonObject.getJSONObject("scores");
                    double max = 0;
                    String emotion = "";
                    for (int j = 0; j < scores.names().length(); j++) {
                        if (scores.getDouble(scores.names().getString(j)) > max) {
                            max = scores.getDouble(scores.names().getString(j));
                            emotion = scores.names().getString(j);
                        }
                    }
                    emotions += emotion + "\n";
                }
                Log.d("gol", emotions);


            } catch (JSONException e) {
            }
        }
    }
}