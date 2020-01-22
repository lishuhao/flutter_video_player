#import "FlutterVideoPlayerPlugin.h"
#import "FlutterVideoPlayer.h"

@implementation FlutterVideoPlayerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterVideoPlayerFactory* factory = [[FlutterVideoPlayerFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:factory withId:@"cn.isanye.qiniu.player"];
}

@end
