import 'disposable_object_list_extension.dart';

/// A mixin for disposable pattern.
///
/// This mixin is useful, when you want to use [DisposableObjectListExtension.disposeAll] for custom classes or for classes from other packages.
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
  /// Disposes an object.
  ///
  /// This method will be called in [DisposableObjectListExtension.disposeAll].
  /// You must implement an actual disposing part.
  void disposeObject();
}
