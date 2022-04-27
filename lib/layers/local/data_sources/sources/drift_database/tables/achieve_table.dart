import 'package:drift/drift.dart';

class AchievementsTable extends Table {
  TextColumn get name => text()();

  TextColumn get section => text()();

  IntColumn get sectionOrder => integer()();

  TextColumn get imageBig => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get condition => text().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get nameI18n => text().nullable()();

  @override
  Set<Column> get primaryKey => {name};
}
