/// Testing utilities for Aqueduct applications
///
/// This library should be imported in test scripts. It should not be imported in application code.
///
/// Example:
///
/// import 'package:test/test.dart';
/// import 'package:aqueduct_2/aqueduct_2.dart';
/// import 'package:aqueduct_2/test.dart';
///
/// void main() {
///   test("...", () async => ...);
/// }
library aqueduct_test;

export 'src/agent.dart';
export 'src/auth_harness.dart';
export 'src/db_harness.dart';
export 'src/harness.dart';
export 'src/matchers.dart';
export 'src/mock_server.dart';
