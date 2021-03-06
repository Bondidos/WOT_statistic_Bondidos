import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/dao/extensions/vehicle_ttc_converting_ext.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/tables/vehicle_ttc.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';

part 'vehicle_ttc_dao.g.dart';

@DriftAccessor(tables: [VehicleTTCTable])
class VehicleTtcDao extends DatabaseAccessor<Database>
    with _$VehicleTtcDaoMixin {
  final Database database;

  VehicleTtcDao(this.database) : super(database);

  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) async {
    int itemsInserted = 0;
    await Future.forEach<VehicleTTCTableCompanion>(
      listTTC.toVehicleTTCTableCompanionList(),
      (element) {
        into(vehicleTTCTable).insertOnConflictUpdate(element);
        itemsInserted++;
      },
    );
    return itemsInserted;
  }

  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) {
    final query = select(vehicleTTCTable)
      ..where((tbl) => tbl.tankId.isIn(tankIds));
    return query
        .map((vehicleTTCTableData) => vehicleTTCTableData.toVehiclesDataTTC())
        .get();
  }
}
