import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryTracker {
  final List<String> directoriesToTrack = [
    // directories
    'D:/Downloads',
    'D:/Downloads/Telegram Desktop',
    'D:/Documents',
    'E:/',
    'D:/',
    'D:/Pictures',
    'D:/Videos',
    'C:/Users/TECHNO/Pictures',
    'C:/Users/TECHNO/Pictures/Screenshots',
    'D:/YT_download'
  ];

  Map<String, List<Map<String, dynamic>>> trackingData = {};
Future<void> trackDirectories() async {
  try {
    String jsonData = await _readJsonFile();

    if (jsonData.isNotEmpty) {
      dynamic decodedData = jsonDecode(jsonData);
      if (decodedData is Map<String, dynamic>) {
        trackingData = decodedData.map((key, value) =>
            MapEntry(key, (value as List<dynamic>).cast<Map<String, dynamic>>()));
      }
    }

    for (var directory in directoriesToTrack) {
      var info = await _getDirectoryInfo(directory);
      trackingData[directory] ??= [];
      trackingData[directory]?.add(info);
    }

    await _writeJsonToFile(jsonEncode(trackingData));
  } catch (e) {
    print('Error in trackDirectories: $e');
    // Handle error appropriately
  }
}

  Future<File> _writeJsonToFile(String json) async {
    // final directory = await getApplicationDocumentsDirectory();
    final file = File('assets/tracking_data.json');
    return file.writeAsString(json);
  }

  Future<String> _readJsonFile() async {
    // final directory = await getApplicationDocumentsDirectory();
    final file = File('assets/tracking_data.json');
    return file.readAsString();
  }

  Future<Map<String, dynamic>> _getDirectoryInfo(String directory) async {
    final dir = Directory(directory);
    final files = await dir
        .list(recursive: false)
        .where((entity) => entity is File)
        .toList();
    final directories = await dir
        .list(recursive: false)
        .where((entity) => entity is Directory)
        .toList();
    final fileCount = files.length;
    final directoryCount = directories.length;
    int totalSize = 0;
    DateTime? lastModified;

    for (final file in files) {
      final stat = await file.stat();
      totalSize += stat.size;
      if (lastModified == null || stat.modified.isAfter(lastModified)) {
        lastModified = stat.modified;
      }
    }

    return {
      'fileCount': fileCount,
      'directoryCount': directoryCount,
      'totalSize': totalSize,
      'lastModified': lastModified?.toIso8601String(),
    };
  }
}
