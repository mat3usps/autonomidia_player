import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/tripy.mp4')
          ..initialize().then((_) {
            _videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController)),
              ])
            : Container(),
      ),
    );
  }
}

class RoundStyledButton extends StatelessWidget {
  final void Function() action;
  final IconData icon;
  final double size;

  const RoundStyledButton(
      {super.key, required this.action, required this.icon, this.size = 80.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                fixedSize: MaterialStateProperty.all(Size(size, size)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size)))),
            onPressed: action,
            child: Icon(icon)));
  }
}
