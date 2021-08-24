import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('How Drag'),
          key: const Key('AppbarTitle'),
        ),
        body: const Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isDragAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Draggable(
          feedback: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              // ignore: avoid_redundant_argument_values
              border: Border.all(width: 2.0, color: Colors.black),
            ),
          ),
          childWhenDragging: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.grey),
            ),
          ),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              // ignore: avoid_redundant_argument_values
              border: Border.all(width: 2.0, color: Colors.black),
            ),
            child: const Center(
              child: Text("Draggable"),
            ),
          ),
        ),
        DragTarget(
          onAccept: (data) {
            setState(() {
              isDragAccepted = true;
            });
          },
          builder: (BuildContext context, candidateData, rejectedData) {
            return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0,
                    color: isDragAccepted ? Colors.green : Colors.black,),
              ),
              child: Center(
                child:
                    Text(isDragAccepted ? "Successful drag!" : "Drag Target"),
              ),
            );
          },
        ),
      ],
    );
  }
}

