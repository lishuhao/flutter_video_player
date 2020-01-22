//
//  FlutterVideoPlayer.m
//  flutter_video_player
//
//  Created by shuhao on 2018/12/23.
//

#import "FlutterVideoPlayer.h"
#import <PLPlayerKit/PLPlayerKit.h>


@implementation FlutterVideoPlayerFactory{
    NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    if(self){
        _messenger = messenger;
    }
    return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    
    FlutterVideoPlayerController* videoPlayerController = [[FlutterVideoPlayerController alloc] initWithFrame:frame
                                                                           viewIdentifier:viewId
                                                                                arguments:args
                                                                          binaryMessenger:_messenger];
    return videoPlayerController;
}

@end


@implementation FlutterVideoPlayerController{
    UIView* _videoView;
}

//初始化
-(instancetype) initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if([super init]){
        PLPlayerOption *option = [PLPlayerOption defaultOption];
        [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
        //NSURL *url = [NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks1"];
        NSURL *url = [NSURL URLWithString:@"http://qn.isanye.cn/%E5%A5%87%E8%BF%B9%E7%9A%84%E5%B1%B1.mp4"];
        self.player = [PLPlayer playerWithURL:url option:option];
        self.player.delegate = self;
        _videoView = self.player.playerView;
        [self.player play];
    }
    return self;
}

- (nonnull UIView *)view {
    return _videoView;
}

// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    // 开始播放，当连接成功后，将收到第一个 PLPlayerStatusCaching 状态
    // 第一帧渲染后，将收到第一个 PLPlayerStatusPlaying 状态
    // 播放过程中出现卡顿时，将收到 PLPlayerStatusCaching 状态
    // 卡顿结束后，将收到 PLPlayerStatusPlaying 状态
    // 点播结束后，将收到 PLPlayerStatusCompleted 状态
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误，停止播放时，会回调这个方法
}

@end
