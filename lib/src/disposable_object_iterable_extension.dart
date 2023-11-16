import 'dart:async';

import 'package:flutter/material.dart';

import 'disposable_object.dart';

/// Extension on [Iterable] that introduces [disposeAll] method.
extension DisposableObjectIterableExtension<T> on Iterable<T> {
  /// Disposes of each element of this iterable.
  ///
  /// Calls
  /// * [ChangeNotifier.dispose] for [ChangeNotifier] items, like [FocusNode], [TextEditingController], etc.
  /// * [StreamController.close] and [StreamSubscription.cancel] for [StreamController] and [StreamSubscription] respectively.
  /// * [Timer.cancel] for [Timer].
  /// * [AnimationEagerListenerMixin.dispose] for [AnimationEagerListenerMixin], like [AnimationController].
  /// * [DisposableObject.disposeObject] for [DisposableObject].
  void disposeAll() {
    for (var item in this) {
      final void Function() disposeItem = switch (item) {
        DisposableObject() => () => item.disposeObject(),
        ChangeNotifier() => () => item.dispose(),
        Sink() => () => item.close(),
        StreamSubscription() => () => item.cancel(),
        Timer() => () => item.cancel(),
        AnimationEagerListenerMixin() => () => item.dispose(),
        Object() => throw UnimplementedError(
            'Dispose action is not implemented in disposable_objects for ${item.runtimeType}'),
      };
      disposeItem();
    }
  }
}
