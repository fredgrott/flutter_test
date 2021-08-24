import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "How BuildContext",
      key: const Key("AppbarTitle"),
      initialRoute: "/page1",
      routes: {
        "/page1": (BuildContext context) => const Page1(),
        "/page2": (BuildContext context) => const Page2(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Page 1")),
    );
  }
}

GlobalKey<ScaffoldState> page2ScaffoldKey = GlobalKey<ScaffoldState>();

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: page2ScaffoldKey,
      body: const Center(child: Text("Page 2")),
    );
  }
}

