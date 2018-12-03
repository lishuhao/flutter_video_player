package plugin.player.qiniu.flutter.isanye.cn.fluttervideoplayer;

import android.content.Context;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class VideoPlayerFactory extends PlatformViewFactory {
    private final PluginRegistry.Registrar registrar;

    VideoPlayerFactory(PluginRegistry.Registrar registrar) {
        super(StandardMessageCodec.INSTANCE);
        this.registrar = registrar;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        System.out.println(o);
        return new VideoPlayerView(context,registrar,i,o);
    }
}
