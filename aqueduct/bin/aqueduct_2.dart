import 'dart:async';
import 'dart:io';

import 'package:aqueduct_2/src/cli/runner.dart';

Future main(List<String> args) async {
  final runner = Runner();
  final values = runner.options.parse(args);
  exitCode = await runner.process(values);
}

