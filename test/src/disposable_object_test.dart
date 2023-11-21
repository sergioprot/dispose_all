import 'package:dispose_all/dispose_all.dart';
import 'package:flutter_test/flutter_test.dart';

class DisposableTest with DisposableObject {
  int disposed = 0;

  @override
  void disposeObject() {
    ++disposed;
  }
}

void main() {
  test('DisposableObject mixin', () {
    final a = DisposableTest();
    expect(a.disposed, 0);
    a.disposeObject();
    expect(a.disposed, 1);
    [a].disposeAll();
    expect(a.disposed, 2);
  });
}
