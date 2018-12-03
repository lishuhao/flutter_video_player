part of flutter_video_player;

class PlayerOptions {
  /// Video path
  /// Local video file path,or rtmp url or hls url
  final String videoPath;

  /// Whether the video is live streaming.
  /// If true, the bottom layer will do some optimization for the live stream.
  final bool isLiveStreaming;

  PlayerOptions({
    this.videoPath,
    this.isLiveStreaming,
  }) : assert(videoPath != null);

  dynamic toJson() => {
        'videoPath': videoPath ?? '',
        'isLiveStreaming': isLiveStreaming ?? false,
      };
}
