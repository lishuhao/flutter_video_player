package plugin.player.qiniu.flutter.isanye.cn.fluttervideoplayer;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.pili.pldroid.player.AVOptions;
import com.pili.pldroid.player.PLOnCompletionListener;
import com.pili.pldroid.player.PLOnErrorListener;
import com.pili.pldroid.player.PLOnInfoListener;
import com.pili.pldroid.player.PLOnPreparedListener;
import com.pili.pldroid.player.PLOnVideoSizeChangedListener;
import com.pili.pldroid.player.widget.PLVideoView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

public class VideoPlayerView implements PlatformView,Application.ActivityLifecycleCallbacks,
        PLOnPreparedListener,PLOnInfoListener,PLOnCompletionListener,PLOnErrorListener,
        PLOnVideoSizeChangedListener,MethodChannel.MethodCallHandler {
    
    private static final String TAG = "VideoPlayerView-------";

    private PluginRegistry.Registrar registrar;
    private PLVideoView videoView;
    private final MethodChannel channel;
    private static final String channelName = "cn.isanye.qiniu.player/channel/";
    
    VideoPlayerView(Context context, PluginRegistry.Registrar registrar, int id, Object creationParams){
        this.registrar = registrar;
        channel = new MethodChannel(registrar.messenger(),channelName + id);
        channel.setMethodCallHandler(this);
        
        this.videoView = new PLVideoView(context);
        AVOptions avOptions = new AVOptions();

        final Map<?, ?> params = (Map<?, ?>)creationParams;
        String videoPath = (String)params.get("videoPath");
        boolean isLiveStreaming = (Boolean) params.get("isLiveStreaming");
        if(isLiveStreaming){
            avOptions.setInteger(AVOptions.KEY_LIVE_STREAMING,1);
        }
        videoView.setAVOptions(avOptions);
        

        videoView.setOnPreparedListener(this);
        videoView.setOnInfoListener(this);
        videoView.setOnVideoSizeChangedListener(this);
        videoView.setOnCompletionListener(this);
        videoView.setOnErrorListener(this);
        
        videoView.setVideoPath(videoPath);
        
    }
    
    @Override
    public View getView() {
        return videoView;
    }
    
    @Override
    public void dispose() {
        videoView.stopPlayback();
        registrar.activity().getApplication().unregisterActivityLifecycleCallbacks(this);
    }



    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method){
            case "start":
                videoView.start();
                break;
            case "pause":
                videoView.pause();
                break;
            case "getMetadata":
                this.getMetadata(result);
                break;
        }
    }
    
    private void getMetadata(MethodChannel.Result result){
        result.success(videoView.getMetadata());
    }

    
    
    @Override
    public void onPrepared(int preparedTime) {
        Log.e(TAG,"preparedTime:"+preparedTime);
        final Map<String, Object> args = new HashMap<>(2);
        args.put("preparedTime",preparedTime);
        args.put("duration",videoView.getDuration());
        args.put("metaData",videoView.getMeasuredHeight());
        
        channel.invokeMethod("onPrepare",args);
    }

    @Override
    public void onVideoSizeChanged(int width, int height) {
        Log.e(TAG,"size:w:"+width+" h:"+height);
    }
    
    @Override
    public void onInfo(int what, int extra) {
        //Log.e(TAG,"w:"+what+" e:"+extra);
        final Map<String, Object> args = new HashMap<>(2);
        args.put("what",what);
        args.put("extra",extra);
        channel.invokeMethod("onInfo",args);
    }
    
    @Override
    public void onCompletion() {
        Log.e(TAG,"onCompletion");
        channel.invokeMethod("onCompletion",null);
    }
    
    @Override
    public boolean onError(int errorCode) {
        Log.e(TAG,"errCode:"+errorCode);
        
        final Map<String, Object> args = new HashMap<>(2);
        args.put("errorCode",errorCode);
        channel.invokeMethod("onError",args);
        return false;
    }

    
    
    //activity life circles
    @Override
    public void onActivityCreated(Activity activity, Bundle bundle) { }

    @Override
    public void onActivityStarted(Activity activity) {}

    @Override
    public void onActivityResumed(Activity activity) {
        videoView.start();
    }

    @Override
    public void onActivityPaused(Activity activity) {
        videoView.pause();
    }

    @Override
    public void onActivityStopped(Activity activity) {}

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {}

    @Override
    public void onActivityDestroyed(Activity activity) {
        videoView.stopPlayback();
    }
}
