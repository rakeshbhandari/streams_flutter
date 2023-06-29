import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //remove bug banner
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //you have to close this explicitly
  final StreamController _streamController = StreamController();
  addData() async {
    for (int i = 1; i <= 15; i++) {
      await Future.delayed(const Duration(seconds: 3));

      _streamController.sink.add(i);
    }
  }

//currently using this not the above syntax
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 15; i++) {
      await Future.delayed(const Duration(seconds: 3));

      yield i;
    }
  }

//closing here
  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream in Flutter'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
          // stream: numberStream().where((number) => number % 2 == 0),
          // this is for filtering evennum from the stream
          stream: numberStream().map((number) => "Number $number"),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('The stream has error');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                  radius: 20.0, color: CupertinoColors.activeBlue);
            }
            return Text(
              "${snapshot.data}",
              style: Theme.of(context).textTheme.displayMedium,
            );
          },
        ),
      ),
    );
  }
}



//sink for input
//stream for output