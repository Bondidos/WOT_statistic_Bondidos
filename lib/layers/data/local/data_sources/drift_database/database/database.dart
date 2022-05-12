import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/achieve_table.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/vehicle_ttc.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/wot_stat_database.dart';

part 'database.g.dart';

@DriftDatabase(
    tables: [UserTable, VehicleTTCTable, AchievementsTable], daos: [WotStatDao])
class WotStatDatabase extends _$WotStatDatabase {
  WotStatDatabase(QueryExecutor e) : super(e);

  WotStatDatabase.connect(DatabaseConnection connection)
      : super.connect(connection);

  @override
  int get schemaVersion => 1;
}
