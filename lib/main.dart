import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flux/folder_data.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final directoryTracker = DirectoryTracker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Directory Tracker')),
      body: FutureBuilder(
        future: directoryTracker.trackDirectories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Data available
            return ListView.builder(
              itemCount: directoryTracker.trackingData.length,
              itemBuilder: (_, index) {
                final directory = directoryTracker.trackingData.keys.elementAt(index);
                final info = directoryTracker.trackingData[directory]!.first;
                return ListTile(
                  title: Text(directory),
                  subtitle: Text('Files: ${info['fileCount']}'),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            directoryTracker.trackDirectories();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}