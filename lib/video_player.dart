import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<String>? videosPaths;

  const VideoPlayerWidget({super.key, required this.videosPaths});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController = _setVideoController();
  }

  _setVideoController() {
    final value = widget.videosPaths?.elementAt(0);
    debugPrint('value $value');
    return VideoController.asset('assets/videos/tripy.mp4')
      ..initialize().then((_) {
        _videoController.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _videoController.value.isInitialized
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController)),
              ])
            : Container(),
      ),
    );
  }
}
