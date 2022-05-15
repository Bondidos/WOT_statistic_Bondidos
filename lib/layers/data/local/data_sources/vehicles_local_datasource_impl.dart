import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local/vehicles_local_datasource.dart';

import 'drift_database/dao/dao.dart';

const vehiclesLng = 'VehiclesLng';
const notPicked = "Not Picked";
const ttcCountInDb = 'TTC count in DB';
const language = 'Language';

class VehiclesLocalDataSourceImpl implements VehiclesLocalDataSource {
  final SharedPreferences sharedPreferences;
  final VehicleTtcDao vehicleTtcDao;

  VehiclesLocalDataSourceImpl(
      {required this.sharedPreferences, required this.vehicleTtcDao});

  @override
  String getVehiclesCurrentLng() =>
      sharedPreferences.getString(vehiclesLng) ?? notPicked;

  @override
  void setVehiclesCurrentLng(String lng) =>
      sharedPreferences.setString(vehiclesLng, lng);

  @override
  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) =>
      vehicleTtcDao.fetchTTCByListOfIDs(tankIds);

  @override
  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) =>
      vehicleTtcDao.saveTTCList(listTTC);

  @override
  int getVehiclesTTCCount() => sharedPreferences.getInt(ttcCountInDb) ?? 0;

  @override
  void setVehiclesTtcCount(int ttcCount) =>
      sharedPreferences.setInt(ttcCountInDb, ttcCount);

  @override
  String getCurrentLng() => sharedPreferences.getString(language) ?? notPicked;
}
