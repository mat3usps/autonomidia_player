import 'package:autonomidia_player/video_player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 229, 129),
        title: const Text("Autonomidia Flutter App"),
        centerTitle: true,
      ),
      body: const VideoPlayerWidget(),
    );
  }
}
