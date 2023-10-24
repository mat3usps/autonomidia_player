import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'util.dart';

class VideoService {
  static updateVideoPlaylist() async {
    final config = jsonDecode(await getFileConfig());

    final videos = config['settings']['video'][0]['files'];
    final localVideos = await getDocumentsDirectoryFiles();
    bool isAMatch = makeComparison(videos, localVideos);

    if (isAMatch) {
      return debugPrint('videos are up to date!');
    }

    final documentsPath = await getDocumentsDirectoryPath();
    String minioServer = config['settings']['minio_server'];
    String path = config['settings']['path'];

    try {
      for (int i = 0; i < videos.length; i++) {
        String filename = videos[i];
        final response = await _makeGetRequest(
            'https://$minioServer/storage/$path/video/$filename.mp4');
        final body = response.body.codeUnits;
        _saveBinaryDataToFile(body, '$documentsPath/$filename.mp4');
      }
    } catch (error) {
      debugPrint('error trying to update videos');
      debugPrint(error.toString());
    }
  }

  static makeComparison(List<dynamic> videosNames, List<File> localVideos) {
    List<String> localVideosNames = extractFilesNames(localVideos);

    videosNames.sort();
    localVideosNames.sort();
    return const ListEquality().equals(videosNames, localVideosNames);
  }

  static extractFilesNames(List<File> files) {
    List<String> names = [];

    for (int i = 0; i < files.length; i++) {
      File file = files[i];
      List<String> splittedPath = file.path.split('/');
      String name =
          splittedPath[splittedPath.length - 1].replaceAll('.mp4', '');
      names.add(name);
    }
    return names;
  }

  static getFileConfig() async {
    Map<String, dynamic> requestBody = {
      "token": "295399ec-ec49-4545-aa8b-4a772ab9ea1e",
      "screen": "1920x1080",
      "uptime": "565",
      "free_space": "25012",
      "version": "4.0",
      "free_mem": "116",
      "mac_address": "b8:27:eb:66:48:6a",
      "local_address": "192.168.0.152",
      "dhcp": "True",
      "camera": "False",
      "gps": "False",
      "wifi_antenna": "False"
    };

    try {
      final response = await _makePostRequest(
          'https://api.simplyas.com/modbox/requestSettings', requestBody);

      if (response.statusCode != 200) {
        debugPrint('Error: ${response.statusCode}');
      }

      return response.body;
    } catch (error) {
      debugPrint('error trying to get videos');
      debugPrint(error.toString());
    }
  }

  static void _saveBinaryDataToFile(List<int> binaryData, String filePath) {
    final File file = File(filePath);
    file.writeAsBytesSync(binaryData);
  }

  static Future _makePostRequest(
      String unparsedUri, Map<String, dynamic> requestBody,
      [Map<String, String>? headers]) async {
    final url = Uri.parse(unparsedUri);

    return await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: headers,
    );
  }

  static Future _makeGetRequest(String unparsedUri,
      [Map<String, String>? headers]) async {
    final url = Uri.parse(unparsedUri);

    return await http.get(
      url,
      headers: headers,
    );
  }
}
