A Flutter package that introduces a convenient way to dispose of objects.

## Features

* `DisposableObject` mixin. Makes any your custom class, or a class which was implemented in another package, usable (and disposable) with this package
* `disposeAll` method for `Iterable` that disposes of every item of that `Iterable`. The elements can be:
  * `DisposableObject`, obviously
  * `ChangeNotifier` and anything that extends or uses it as a mixin, e.g. `TextEditingController`, `FocusNode`, `ScrollController` and much more
  * `Sink`, e.g. `StreamController`
  * `StreamSubscription`
  * `Timer`
  * `AnimationEagerListenerMixin`, e.g. `AnimationController`

## Usage

### Disposing of a list of objects

Define objects that must be disposed of later:
```dart
final textEditingController = TextEditingController();
final focusNode = FocusNode();
final stream = StreamController.broadcast();
final listener = someStream.listen(...);
final timer = Timer.periodic(...);
final animationController = AnimationController(...);
```

Put them all in an Iterable:
```dart
final disposables = [
  textEditingController,
  focusNode,
  stream,
  listener,
  timer,
  animationController,
];
```

Dispose of all objects when they are no longer needed:
```dart
disposables.disposeAll();
```

### Make custom class disposable

Custom classes instances cannot be disposed of by using `disposeAll()` method by default.
Luckily, there's an easy way to add such functionality to any class by `DisposableObject` mixin:

```dart
class DisposableTest with DisposableObject {
  bool disposed = false; // or anything you need

  @override
  void disposeObject() {
    disposed = true; // or anything you'd like to do
  }
}
```

Now `DisposableTest` objects can be disposed of by `disposeAll` method:

```dart
final myDisposable = DisposableTest();
...
[
  myDisposable,
  ...
].disposeAll();
```

Let's say you use [Dio](https://pub.dev/packages/dio) package for handling http requests. You might be using `CancelToken` objects to cancel http requests when you leave a page before http request is finished.
Calling `disposeAll` method on a list, where one of the elements is `CancelToken` will lead to throwing `UnimplementedError`. But you can easily make a wrapper for `CancelToken` to make things working:

```dart
import 'package:dio/dio.dart';

class CancelTokenDisposable extends CancelToken with DisposableObject {
  @override
  void disposeObject() {
    cancel();
  }
}
```

Now `CancelTokenDisposable` instances can be disposed of by `disposeAll` method:

```dart
class _MyWidgetState extends State<MyWidget> {
  List _disposables = [];

  CancelTokenDisposable cancelToken = CancelTokenDisposable();

  @override
  void initState() {
    super.initState();
    _disposables = [
      cancelToken,
      ...
    ];
  }

  @override
  Widget build(BuildContext context) {
    ...
  }

  @override
  void dispose() {
    _disposables.disposeAll();
    super.dispose();
  }
}
```

## Contribution

Please feel free to open an issue on GitHub, if you feel like this package misses some functionality required for your project.
