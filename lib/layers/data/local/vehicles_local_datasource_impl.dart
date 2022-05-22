import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';
import 'package:wot_statistic/layers/data/sources/local/vehicles_local_datasource.dart';
import 'package:wot_statistic/layers/data/sources/settings/database_settings.dart';
import 'package:wot_statistic/layers/data/sources/settings/language_settings.dart';
import 'data_sources/drift_database/dao/dao.dart';

class VehiclesLocalDataSourceImpl implements VehiclesLocalDataSource {
  final DatabaseSettings databaseSettings;
  final VehicleTtcDao vehicleTtcDao;
  final LanguageSettings languageSettings;

  const VehiclesLocalDataSourceImpl({
    required this.languageSettings,
    required this.vehicleTtcDao,
    required this.databaseSettings,
  });

  @override
  void setVehiclesCurrentLanguage() =>
      languageSettings.setDatabaseCurrentLanguage(languageSettings.appLanguage);

  @override
  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) =>
      vehicleTtcDao.fetchTTCByListOfIDs(tankIds);

  @override
  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) =>
      vehicleTtcDao.saveTTCList(listTTC);

  @override
  int get vehiclesTTCCount => databaseSettings.vehiclesTTCCount;

  @override
  void setVehiclesTtcCount(int ttcCount) =>
      databaseSettings.setVehiclesTtcCount(ttcCount);

  @override
  bool get isVehiclesDBAndAppLanguagesSame =>
      languageSettings.databaseCurrentLanguage == languageSettings.appLanguage;
}
