package co.edu.eafit.dis.p2.memories;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;

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
                        if (call.method.equals("sendEmotion")) {
                            sendEmotion((String)call.argument("path"));
                            result.success("success");

                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }

    private void sendEmotion(String path) {
        getEmotion(path);
    }

    public static byte[] toBase64(String filePath) {

        File imgFile = new File(filePath);
        if(imgFile.exists())
        {
            Bitmap bm = BitmapFactory.decodeFile(imgFile.getAbsolutePath());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            bm.compress(Bitmap.CompressFormat.JPEG, 100, baos);
            return baos.toByteArray();
        }
        Log.e("Base 64 Error", " toBase64 error");
        return null;

    }

    public void getEmotion(String path) {
        // run the GetEmotionCall class in the background
        GetEmotionCall emotionCall = new GetEmotionCall(path);
        emotionCall.execute();
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
/*            HttpClient httpclient = HttpClients.createDefault();
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);*/


            try {
                //URIBuilder builder = new URIBuilder("https://eastus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion");
                OkHttpClient httpClient = new OkHttpClient();
                RequestBody requestBody = RequestBody.create(MediaType.parse("application/octet-stream"),new File(path));

                Request request = new Request.Builder()
                        .url("https://eastus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=emotion")
                        .addHeader("Ocp-Apim-Subscription-Key", "0f9ebeaedb9f495c80fde9a845241dc1")
                        .addHeader("Content-Type","application/octet-stream")
                        .post(requestBody)
                        .build();
                Log.e("Request",request.toString());
                Call call = httpClient.newCall(request);
                Response response = call.execute();
                Log.e("APIII",response.body().string());
                return response.body().string();

               /* URI uri = builder.build();
                HttpPost request = new HttpPost(uri);
                request.setHeader("Content-Type", "application/octet-stream");
                request.setHeader("Ocp-Apim-Subscription-Key", "0f9ebeaedb9f495c80fde9a845241dc1");


                // Request body. The parameter of setEntity converts the image to base64
                request.setEntity(new ByteArrayEntity(toBase64(path)));


                // getting a response and assigning it to the string res
                HttpResponse response = httpclient.execute(request);
                HttpEntity entity = response.getEntity();
                return EntityUtils.toString(entity);*/

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
                Log.d("gol", emotions);


            } catch (JSONException e) {
                if (result.contains("anger")) {
                    //nothing wrong.
                } else {
                    Log.d("Face api error:", e.getMessage());
                }
            }

        }

    }

}