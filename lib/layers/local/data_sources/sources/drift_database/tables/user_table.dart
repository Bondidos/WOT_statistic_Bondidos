import 'package:drift/drift.dart';


//https://github.com/Sproute777/flutter_drift_explore.git
class UserTable extends Table {
  IntColumn get id => integer()();
  TextColumn get nickname => text()();
  TextColumn get token => text()();
  IntColumn get expiresAt => integer()();
  TextColumn get realm => text()();

  @override
  Set<Column> get primaryKey => {id};
}

