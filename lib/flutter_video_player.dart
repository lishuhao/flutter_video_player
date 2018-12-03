library flutter_video_player;

//Reference document：https://developer.qiniu.com/pili/sdk/1210/the-android-client-sdk

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/player_options.dart';
part 'src/video_controller.dart';
part 'src/video_player.dart';

typedef void VideoCreatedCallback(VideoController controller);

typedef void PreparedCallback();

typedef void CompletionCallBack();

typedef void VideoSizeChangedCallback(int width, int height);

typedef void VideoInfoCallback(int what, int extra);

typedef void ErrorCallback(int errorCode);
