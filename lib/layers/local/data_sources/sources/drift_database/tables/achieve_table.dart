import 'package:drift/drift.dart';

class AchievementsTable extends Table {
  TextColumn get name => text()();

  TextColumn get section => text()();

  TextColumn get sectionOrder => text()();

  TextColumn get imageBig => text()();

  TextColumn get image => text()();

  TextColumn get condition => text()();

  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {name};
}
