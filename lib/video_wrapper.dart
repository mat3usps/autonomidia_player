import 'dart:io';
import 'util.dart';
import 'package:flutter/material.dart';
import 'package:modbox_player/video_player.dart';

class VideoWrapperWidget extends StatefulWidget {
  const VideoWrapperWidget({super.key});

  @override
  State<VideoWrapperWidget> createState() => _VideoWrapperState();
}

class _VideoWrapperState extends State<VideoWrapperWidget> {
  late Future<dynamic> _videosPaths;

  @override
  void initState() {
    super.initState();
    _videosPaths = _getVideosPaths();
  }

  _getVideosPaths() async {
    final documents = await getDocumentsDirectoryFiles();
    List<String> paths = [];
    for (int i = 0; i < documents.length; i++) {
      File document = documents[i];
      paths.add(document.path);
    }
    return paths;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _videosPaths,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final paths = snapshot.data;
          return Scaffold(body: VideoPlayerWidget(videosPaths: paths));
        }
      },
    );
  }
}
