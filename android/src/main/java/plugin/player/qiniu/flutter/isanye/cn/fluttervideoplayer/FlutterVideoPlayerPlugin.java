package plugin.player.qiniu.flutter.isanye.cn.fluttervideoplayer;

import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterVideoPlayerPlugin {

  private static final String viewType = "cn.isanye.qiniu.player";
  
  public static void registerWith(Registrar registrar) {

    registrar.platformViewRegistry().registerViewFactory(viewType,new VideoPlayerFactory(registrar));
  }
}
