import 'package:drift/drift.dart';
import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_images.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';

extension VehiclesTTCConverting on VehiclesDataTTC {
  VehicleTTCTableCompanion toVehicleTTCTableCompanion() =>
      VehicleTTCTableCompanion(
        description: Value(description),
        images: Value(images.bigIcon),
        isPremium: Value(isPremium),
        isGift: Value(isGift),
        name: Value(name),
        nation: Value(nation),
        type: Value(type),
        tankId: Value(tankId),
        tier: Value(tier),
      );
}

extension VehicleTTCTableDataConverting on VehicleTTCTableData {
  VehiclesDataTTC toVehiclesDataTTC() => VehiclesDataTTC(
        description: description,
        images: VehiclesDataImages(bigIcon: images),
        isPremium: isPremium,
        isGift: isGift,
        nation: nation,
        name: name,
        type: type,
        tankId: tankId,
        tier: tier,
      );
}