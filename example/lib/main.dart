import 'dart:async';

import 'package:dispose_all/dispose_all.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dispose_all'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          ),
          child: const Text('Go'),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // A List of disposable objects that are used on this screen
  List _disposables = [];

  // A couple of actually disposable objects
  final TextEditingController _inputController = TextEditingController();
  late Timer _timer;

  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        ++_seconds;
      });
    });

    // Initializing a List of disposable objects
    _disposables = [
      _inputController,
      _timer,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dispose_all'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _inputController,
            onChanged: (_) => setState(() {}),
          ),
          Text(_inputController.text),
          Text('Seconds after startup: $_seconds'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Easy disposing of all disposable objects
    _disposables.disposeAll();
    super.dispose();
  }
}
