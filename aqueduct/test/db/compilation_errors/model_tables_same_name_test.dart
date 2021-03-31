import 'package:aqueduct_2/aqueduct_2.dart';
import 'package:test/test.dart';

void main() {
  test("Two entities with same tableName should throw exception", () {
    try {
      var _ = ManagedDataModel([SameNameOne, SameNameTwo]);
      expect(true, false);
    } on ManagedDataModelError catch (e) {
      expect(e.message, contains("SameNameOne"));
      expect(e.message, contains("SameNameTwo"));
      expect(e.message, contains("'fo'"));
    }
  });
}

class SameNameOne extends ManagedObject<_SameNameOne> {}

class _SameNameOne {
  @primaryKey
  int id;

  static String tableName() => "fo"; // ignore: unused_element
}

class SameNameTwo extends ManagedObject<_SameNameTwo> {}

class _SameNameTwo {
  @primaryKey
  int id;

  static String tableName() => "fo"; // ignore: unused_element
}
