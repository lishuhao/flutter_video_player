part of flutter_video_player;

const String viewType = 'cn.isanye.qiniu.player';

class FlutterVideoPlayer extends StatefulWidget {
  final PlayerOptions options;
  final VideoCreatedCallback onVideoCreated;
  final PreparedCallback onPrepare;
  final VideoSizeChangedCallback onVideoSizeChanged;
  final VideoInfoCallback onVideoInfo;
  final CompletionCallBack onCompletion;
  final ErrorCallback onError;

  FlutterVideoPlayer({
    Key key,
    this.options,
    this.onVideoCreated,
    this.onPrepare,
    this.onVideoSizeChanged,
    this.onVideoInfo,
    this.onCompletion,
    this.onError,
  })  : assert(options.videoPath != null),
        super(key: key);

  @override
  _FlutterVideoPlayerState createState() => _FlutterVideoPlayerState();
}

class _FlutterVideoPlayerState extends State<FlutterVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: viewType,
        creationParams: widget.options.toJson(),
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: viewType,
        creationParams: widget.options.toJson(),
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text(
        '$defaultTargetPlatform is not yet supported by the flutter_video_player plugin');
  }

  void _onPlatformViewCreated(int id) {
    VideoController controller = VideoController._(
      id,
      onPrepare: widget.onPrepare,
      onVideoSizeChanged: widget.onVideoSizeChanged,
      onVideoInfo: widget.onVideoInfo,
      onCompletion: widget.onCompletion,
      onError: widget.onError,
    );
    widget.onVideoCreated(controller);
  }
}
