import 'package:drift/drift.dart';

class VehicleTTCTable extends Table {
  TextColumn get description => text()();

  TextColumn get images => text()();

  BoolColumn get isPremium => boolean()();

  BoolColumn get isGift => boolean()();

  TextColumn get name => text()();

  TextColumn get nation => text()();

  TextColumn get type => text()();

  IntColumn get tankId => integer()();

  IntColumn get tier => integer()();

  @override
  Set<Column> get primaryKey => {tankId};
}
