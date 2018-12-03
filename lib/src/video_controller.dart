part of flutter_video_player;

const channel = 'cn.isanye.qiniu.player/channel/';

class VideoController {
  MethodChannel _channel;
  PreparedCallback onPrepare;
  VideoSizeChangedCallback onVideoSizeChanged;
  VideoInfoCallback onVideoInfo;
  CompletionCallBack onCompletion;
  ErrorCallback onError;

  VideoController._(
    int id, {
    this.onPrepare,
    this.onVideoSizeChanged,
    this.onVideoInfo,
    this.onCompletion,
    this.onError,
  }) {
    _channel = MethodChannel(channel + id.toString());
    _channel.setMethodCallHandler(_onMethodCall);
  }

  void start() async {
    await _channel.invokeMethod('start');
  }

  void pause() async {
    await _channel.invokeMethod('pause');
  }

  getMetaData() async {
    var result = await _channel.invokeMethod('getMetadata');
    print(result);
  }

  Future<dynamic> _onMethodCall(MethodCall call) {
    print(call.method);
    print(call.arguments);
    switch (call.method) {
      case "onPrepare":
        if (onPrepare != null) {
          this.onPrepare();
        }
        break;
      case "onVideoSizeChanged":
        _onVideoSizeChanged(call);
        break;
      case "onInfo":
        _onVideoInfo(call);
        break;
      case "onCompletion":
        if (onCompletion != null) {
          onCompletion();
        }
        break;
      case "onError":
        _onError(call);
        break;
    }
    return null;
  }

  _onVideoSizeChanged(MethodCall call) {
    if (onVideoSizeChanged != null) {
      final int width = call.arguments['width'];
      final int height = call.arguments['height'];

      onVideoSizeChanged(width, height);
    }
  }

  _onVideoInfo(MethodCall call) {
    if (onVideoInfo != null) {
      final int what = call.arguments['what'];
      final int extra = call.arguments['extra'];

      onVideoSizeChanged(what, extra);
    }
  }

  _onError(MethodCall call) {
    if (onError != null) {
      final int errorCode = call.arguments['errorCode'];

      onError(errorCode);
    }
  }
}
