import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> getDocumentsDirectoryPath() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String documentsPath = documentsDirectory.path;
  return documentsPath;
}

Future<List<File>> getDocumentsDirectoryFiles() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final documents = documentsDirectory.list();
  List<File> videoFiles = [];

  await for (FileSystemEntity entity in documents) {
    if (entity is File && entity.path.endsWith('.mp4')) {
      videoFiles.add(entity);
    }
  }
  return videoFiles;
}
