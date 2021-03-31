import 'dart:async';

import 'package:aqueduct_2/aqueduct_2.dart';
import 'package:runtime_2/runtime_2.dart';
import 'package:test/test.dart';

void main() {
  test("A controller that is not Recyclable, but declares a setter throws a runtime error", () {
    try {
      RuntimeContext.current;
      fail('unreachable');
    } on StateError catch (e) {
      expect(e.toString(), contains("MutableSetterController"));
    }
  });
}

class MutableSetterController extends Controller {
  set mutableSetter(String s) {}

  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    return request;
  }
}
