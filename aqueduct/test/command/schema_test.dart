// ignore: unnecessary_const
@Tags(const ["cli"])
import 'package:runtime_2/runtime_2.dart';
import 'package:test/test.dart';

import '../not_tests/cli_helpers.dart';

void main() {
  CLIClient cli;

  // This group handles checking the tool itself,
  // not the behavior of creating the appropriate migration file given schemas
  setUp(() async {
    cli = await CLIClient(CommandLineAgent(ProjectAgent.projectsDirectory)).createProject();
    await cli.agent.getDependencies(offline: true);
    cli.agent.addOrReplaceFile("lib/application_test.dart", """
import 'package:aqueduct_2/aqueduct_2.dart';

class TestObject extends ManagedObject<_TestObject> {}

class _TestObject {
  @primaryKey
  int id;

  String foo;
}
      """);

    return null;
  });

  tearDown(ProjectAgent.tearDownAll);

  test("Ensure migration directory will get created on generation", () async {
    var res = await cli.run("db", ["schema"]);
    expect(res, 0);
    expect(cli.output, contains("_TestObject"));
  });
}
