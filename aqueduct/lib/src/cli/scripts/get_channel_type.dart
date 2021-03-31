import 'dart:async';
import 'dart:mirrors';

import 'package:aqueduct_2/src/application/channel.dart';
import 'package:isolate_executor_2/isolate_executor_2.dart';
import 'package:runtime_2/runtime_2.dart';

class GetChannelExecutable extends Executable<String> {
  GetChannelExecutable(Map<String, dynamic> message) : super(message);

  @override
  Future<String> execute() async {
    final channels = RuntimeContext.current.runtimes.iterable.whereType<ChannelRuntime>();
    if (channels.length != 1) {
      throw StateError("No ApplicationChannel subclass was found for this project. "
          "Make sure it is imported in your application library file.");
    }
    var runtime = channels.first;

    if (runtime == null) {
      return null;
    }
    return MirrorSystem.getName(reflectClass(runtime.channelType).simpleName);
  }

  static List<String> importsForPackage(String packageName) =>
      ["package:aqueduct_2/aqueduct_2.dart", "package:$packageName/$packageName.dart", "package:runtime_2/runtime_2.dart"];
}
