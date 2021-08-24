import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('How Find'),
          key: const Key('AppbarTitle'),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => log("elevated button was clicked"),
              child: const Text("we will find this by searching for a type"),
            ),
            const Text(
              "we will find this by searching for text",
            ),
            const Text(
              "will will find this by searching for a key",
              key: Key("mykey"),
            ),
          ],
        ),
      ),
    );
  }
}

