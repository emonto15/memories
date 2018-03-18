package co.edu.eafit.dis.p2.memories;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.net.URI;
import java.util.concurrent.ExecutionException;

import cz.msebera.android.httpclient.HttpEntity;
import cz.msebera.android.httpclient.HttpResponse;
import cz.msebera.android.httpclient.client.HttpClient;
import cz.msebera.android.httpclient.client.methods.HttpPost;
import cz.msebera.android.httpclient.client.utils.URIBuilder;
import cz.msebera.android.httpclient.entity.ByteArrayEntity;
import cz.msebera.android.httpclient.impl.client.HttpClients;
import cz.msebera.android.httpclient.util.EntityUtils;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/battery";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("getBatteryLevel")) {
                            Log.d("Path", (String)call.argument("path"));
                            //String path = "/storage/2F94-BF11/Pictures/Fotos/IMG-20161109-WA0006.jpeg";
                            int batteryLevel = getBatteryLevel((String)call.argument("path"));

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }

    private int getBatteryLevel(String path) {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        getEmotion(path);

        return batteryLevel;
    }

    public byte[] toBase64(String filePath) {

        File imgFile = new File(filePath);
        if(imgFile.exists())
        {
            Bitmap bm = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            bm.compress(Bitmap.CompressFormat.JPEG, 100, baos);
            return baos.toByteArray();
        }

        //Bitmap bm = BitmapFactory.decodeFile(filePath);

        return null;

    }

    public String getEmotion(String path) {
        // run the GetEmotionCall class in the background
        GetEmotionCall emotionCall = new GetEmotionCall(path);
        Log.d("path", path);
        try {
            return emotionCall.execute().get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
        return "";
    }


    private class GetEmotionCall extends AsyncTask<Void, Void, String> {
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
            HttpClient httpclient = HttpClients.createDefault();
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);


            try {
                URIBuilder builder = new URIBuilder("https://eastus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion");


                URI uri = builder.build();
                HttpPost request = new HttpPost(uri);
                request.setHeader("Content-Type", "application/octet-stream");
                request.setHeader("Ocp-Apim-Subscription-Key", "0f9ebeaedb9f495c80fde9a845241dc1");


                // Request body. The parameter of setEntity converts the image to base64
                request.setEntity(new ByteArrayEntity(toBase64(path)));


                // getting a response and assigning it to the string res
                HttpResponse response = httpclient.execute(request);
                HttpEntity entity = response.getEntity();
                String res = EntityUtils.toString(entity);

                Log.d("res", res);
                return res;
            } catch (Exception e) {
                return "null";
            }

        }


        @Override
        protected void onPostExecute(String result) {

            Log.d("res post", result);

            JSONArray jsonArray = null;
            try {
                // convert the string to JSONArray
                jsonArray = new JSONArray(result);
                String emotions = "";
                // get the scores object from the results
                for (int i = 0; i < jsonArray.length(); i++) {
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
                Log.d("gol", "AQUIIIIIIIIIIIIIIIII"+ emotions);


            } catch (JSONException e) {
                Log.d("no gol", "AQUIIIIIIIIIIIIIIIIINo emotion detected. Try again later");
            }

        }

    }

}