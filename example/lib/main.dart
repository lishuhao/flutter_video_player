import 'package:flutter/material.dart';
import 'package:flutter_video_player/flutter_video_player.dart';

void main() => runApp(MyApp());

//const String videoPath = 'rtmp://live.hkstv.hk.lxdns.com/live/hks1';
const String videoPath =
    'http://qn.isanye.cn/%E5%A5%87%E8%BF%B9%E7%9A%84%E5%B1%B1.mp4';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VideoController _controller;
  double _aspectRatio = 4 / 3;

  _onVideoCreated(VideoController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter video player example'),
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: _aspectRatio,
            child: FlutterVideoPlayer(
              options: PlayerOptions(
                videoPath: videoPath,
              ),
              onVideoCreated: _onVideoCreated,
              onPrepare: () {
                _controller.start();
              },
              onVideoSizeChanged: (int width, int height) {
                setState(() {
                  _aspectRatio = width / height;
                });
              },
            ),
          ),
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
            child: Text('START'),
            onPressed: () {
              _controller.start();
              _controller.getMetaData();
            },
          ),
          FlatButton(
            child: Text('PAUSE'),
            onPressed: () {
              _controller.pause();
            },
          ),
        ],
      ),
    );
  }
}
