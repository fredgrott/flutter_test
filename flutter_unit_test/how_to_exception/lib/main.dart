import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How Exception',
      key: const Key("AppbarTitle"),
      home: Scaffold(
        body: Column(children: [
          ElevatedButton(
            child: const Text("Throw Exception"),
            onPressed: () {
              throw Exception();
            },
          ),
          ElevatedButton(
            child: const Text("Throw MyCustomException"),
            onPressed: () {
              throw MyCustomException();
            },
          ),
        ]),
      ),
    );
  }
}

class MyCustomException implements Exception {
  MyCustomException();
}

