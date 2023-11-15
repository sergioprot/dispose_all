import 'dart:async';

import 'package:disposable_objects/disposable_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DisposableTest with DisposableObject {
  int disposed = 0;
  @override
  void disposeObject() {
    ++disposed;
  }
}

void main() {
  test('Iterable extension', () {
    final disposableTest = DisposableTest();
    final stream = StreamController.broadcast();
    final listener = stream.stream.listen((event) {});

    final disposables = [
      disposableTest,
      FocusNode(),
      TextEditingController(),
      stream,
      listener,
      Timer.periodic(const Duration(milliseconds: 100), (timer) {}),
      AnimationController(vsync: const TestVSync()),
    ];
    expect(disposableTest.disposed, 0);
    disposables.disposeAll();
    expect(disposableTest.disposed, 1);
  });

  test('Unimplemented error', () {
    expect(
        () => [Container()].disposeAll(), throwsA(isA<UnimplementedError>()));
  });
}
