import 'dart:io';

import 'package:dart_example/time.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}');
  });
  Logger('app').info('flutter_example is starting');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Membrane Template',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Membrane Template Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<String> _clock() {
    const timeApi = TimeApi();
    return timeApi.currentTime().map((time) {
      return 'Rust says it has been ${commafy(time.toString())} seconds since January 1, 1970';
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: StreamBuilder(
          stream: _clock(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: const TextStyle(fontSize: 30, color: Colors.blue),
              );
            } else {
              final TextSpan message;
              if (Platform.isMacOS) {
                message = const TextSpan(
                  text:
                      'Have you set envar DYLD_LIBRARY_PATH to point to the directory which contains librust_example.dylib?',
                );
              } else {
                message = const TextSpan(
                  text:
                      'Have you set envar LD_LIBRARY_PATH to point to the directory which contains librust_example.so?',
                );
              }

              return RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'No data.\n\n',
                          style: TextStyle(fontSize: 30, color: Colors.red)),
                      message
                    ],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }
}

String commafy(String value) {
  var input = value.codeUnits.reversed.toList();
  List<int> chunks = [];
  int chunkSize = 3;
  for (var i = 0; i < input.length; i += chunkSize) {
    chunks.addAll(input.sublist(
        i, i + chunkSize > input.length ? input.length : i + chunkSize));
    chunks.add(','.codeUnits[0]);
  }
  return String.fromCharCodes(chunks.reversed).replaceFirst(',', '');
}
