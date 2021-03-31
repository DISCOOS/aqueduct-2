import 'package:aqueduct_2/src/db/managed/managed.dart';
import 'package:aqueduct_2/src/db/postgresql/builders/column.dart';
import 'package:aqueduct_2/src/db/postgresql/builders/table.dart';

class ColumnValueBuilder extends ColumnBuilder {
  ColumnValueBuilder(TableBuilder table, ManagedPropertyDescription property, dynamic value) : super(table, property) {
    this.value = convertValueForStorage(value);
  }

  dynamic value;
}
