import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _incrementCounter();
          if (kIsWeb) {
            print('Running on Web!');
          } else if (Platform.isAndroid) {
            print('Running on Android!');
          } else if (Platform.isIOS) {
            print('Running on iOS!');
          } else if (Platform.isMacOS) {
            print('Running on macOS!');
          } else if (Platform.isWindows) {
            print('Running on Windows!');
          } else if (Platform.isLinux) {
            print('Running on Linux!');
          } else if (Platform.isFuchsia) {
            print('Running on Fuchsia!');
          } 
        },
        tooltip: 'Increment',
        icon: const Icon(Icons.broadcast_on_personal_outlined),
        label: const Text("Checl current platform"),
      ),
    );
  }
}
