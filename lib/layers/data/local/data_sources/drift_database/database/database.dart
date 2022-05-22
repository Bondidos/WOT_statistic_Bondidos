import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/achieve_table.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/vehicle_ttc.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/dao/dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [UserTable, VehicleTTCTable, AchievementsTable],
  daos: [AchievementDao, UserDao, VehicleTtcDao],
)
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  Database.connect(DatabaseConnection connection) : super.connect(connection);

  @override
  int get schemaVersion => 1;
}
