import 'disposable_object_iterable_extension.dart';

/// A mixin for disposable objects.
///
/// This mixin is useful, when you want to use [DisposableObjectIterableExtension.disposeAll] for custom classes or for classes from other packages.
/// Example: (Popular HTTP networking package Dio's CancelToken):
/// ```
/// import 'package:dio/dio.dart';
///
/// class CancelTokenDisposable extends CancelToken with DisposableObject {
///   @override
///   void disposeObject() {
///     cancel();
///   }
/// }
/// ```
mixin DisposableObject {
  /// Disposes of object.
  ///
  /// This method will be called in [DisposableObjectIterableExtension.disposeAll].
  /// You must implement an actual disposing part.
  void disposeObject();
}
