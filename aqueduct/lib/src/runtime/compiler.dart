import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';

import 'package:aqueduct_2/aqueduct_2.dart';
import 'package:aqueduct_2/src/application/channel.dart';
import 'package:aqueduct_2/src/runtime/orm/data_model_compiler.dart';
import 'package:aqueduct_2/src/runtime/impl.dart';
import 'package:runtime_2/runtime_2.dart';

class AqueductCompiler extends Compiler {
  @override
  Map<String, dynamic> compile(MirrorContext context) {
    final m = <String, dynamic>{};

    m.addEntries(
        context.getSubclassesOf(ApplicationChannel).map((t) => MapEntry(_getClassName(t), ChannelRuntimeImpl(t))));
    m.addEntries(
        context.getSubclassesOf(Serializable).map((t) => MapEntry(_getClassName(t), SerializableRuntimeImpl(t))));
    m.addEntries(context.getSubclassesOf(Controller).map((t) => MapEntry(_getClassName(t), ControllerRuntimeImpl(t))));

    m.addAll(DataModelCompiler().compile(context));

    return m;
  }

  String _getClassName(ClassMirror mirror) {
    return MirrorSystem.getName(mirror.simpleName);
  }

  @override
  List<Uri> getUrisToResolve(BuildContext context) {
    return context.context.getSubclassesOf(ManagedObject).map((c) => c.location.sourceUri).toList();
  }

  @override
  void deflectPackage(Directory destinationDirectory) {
    final libFile = File.fromUri(destinationDirectory.uri.resolve("lib/").resolve("aqueduct_2.dart"));
    final contents = libFile.readAsStringSync();
    libFile.writeAsStringSync(contents.replaceFirst("export 'package:aqueduct_2/src/runtime/compiler.dart';", ""));
  }

  @override
  void didFinishPackageGeneration(BuildContext context) {
    if (context.forTests) {
      print("Copying aqueduct_test...");
      copyDirectory(
          src: context.sourceApplicationDirectory.uri.resolve("../").resolve("aqueduct_test/"),
          dst: context.buildPackagesDirectory.uri.resolve("aqueduct_test/"));
      final targetPubspecFile = File.fromUri(context.buildDirectoryUri.resolve("pubspec.yaml"));
      final pubspecContents = json.decode(targetPubspecFile.readAsStringSync());
      pubspecContents["dev_dependencies"]["aqueduct_test"]["path"] = "packages/aqueduct_test";
      pubspecContents["dependency_overrides"]["aqueduct_2"] = pubspecContents["dependencies"]["aqueduct_2"];
      targetPubspecFile.writeAsStringSync(json.encode(pubspecContents));
    }
  }
}
