//
//  FlutterVideoPlayer.h
//  Pods
//
//  Created by shuhao on 2018/12/23.
//
#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayerKit.h>

@interface FlutterVideoPlayerFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype _Nullable )initWithMessenger:(NSObject<FlutterBinaryMessenger>*_Nonnull)messenger;

@end

@interface FlutterVideoPlayerController : NSObject <FlutterPlatformView,PLPlayerDelegate>

- (instancetype _Nullable )initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*_Nullable)messenger;

-(UIView*_Nonnull) view;

@property (nonatomic, strong) PLPlayer  * _Nullable player;

@end
