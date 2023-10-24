import 'package:modbox_player/video_service.dart';
import 'package:modbox_player/video_wrapper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    VideoService.updateVideoPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VideoWrapperWidget(),
    );
  }
}
