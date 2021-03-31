import 'dart:async';

import 'package:aqueduct_2/aqueduct_2.dart';
import 'package:runtime_2/runtime_2.dart';
import "package:test/test.dart";

void main() {
  test("Cannot bind dynamic to header", () {
    try {
      RuntimeContext.current;
      fail('unreachable');
    } on StateError catch (e) {
      expect(e.toString(), contains("Invalid binding 'x' on 'ErrorListPath.get1'"));
    }
  });
}

class ErrorListPath extends ResourceController {
  @Operation.get('id')
  Future<Response> get1(@Bind.path("id") List<String> x) async {
    return Response.ok(null);
  }
}
