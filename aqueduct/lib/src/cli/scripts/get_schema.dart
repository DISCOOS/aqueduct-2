import 'dart:async';

import 'package:aqueduct_2/aqueduct_2.dart';
import 'package:aqueduct_2/src/cli/command.dart';
import 'package:aqueduct_2/src/cli/mixins/project.dart';
import 'package:isolate_executor_2/isolate_executor_2.dart';

class GetSchemaExecutable extends Executable<Map<String, dynamic>> {
  GetSchemaExecutable(Map<String, dynamic> message) : super(message);

  @override
  Future<Map<String, dynamic>> execute() async {
    try {
      var dataModel = ManagedDataModel.fromCurrentMirrorSystem();
      var schema = Schema.fromDataModel(dataModel);
      return schema.asMap();
    } on SchemaException catch (e) {
      return {"error": e.message};
    } on ManagedDataModelError catch (e) {
      return {"error": e.message};
    }
  }

  static List<String> importsForPackage(String packageName) => [
        "package:aqueduct_2/aqueduct_2.dart",
        "package:$packageName/$packageName.dart",
        "package:runtime_2/runtime_2.dart"
      ];
}

Future<Schema> getProjectSchema(CLIProject project) async {
  final response = await IsolateExecutor.run(GetSchemaExecutable({}),
      imports: GetSchemaExecutable.importsForPackage(project.libraryName),
      packageConfigURI: project.packageConfigUri,
      logHandler: project.displayProgress);

  if (response.containsKey("error")) {
    throw CLIException(response["error"] as String);
  }

  return Schema.fromMap(response);
}
