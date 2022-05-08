import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';
import 'package:wot_statistic/layers/data/sources/local/vehicles_local_datasource.dart';

import 'drift_database/dao/wot_stat_dao.dart';

const signedUserId = 'Singed User id';
const signedUserNickname = 'Singed User nickname';
const signedUserToken = 'Singed User token';
const signedUserExpire = 'Singed User EXPIRE';
const signedUserRealm = 'Singed User realm';
const vehiclesLng = 'VehiclesLng';
const notPicked = "Not Picked";
const ttcCountInDb = 'TTC count in DB';
const lngKey = 'Language';

class VehiclesLocalDataSourceImpl implements VehiclesLocalDataSource {
  final SharedPreferences sharedPreferences;
  final WotStatDao wotStatDao;

  VehiclesLocalDataSourceImpl(
      {required this.sharedPreferences, required this.wotStatDao});

  @override
  String getVehiclesCurrentLng() =>
      sharedPreferences.getString(vehiclesLng) ?? notPicked;

  @override
  void setVehiclesCurrentLng(String lng) =>
      sharedPreferences.setString(vehiclesLng, lng);

  @override
  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds) =>
      wotStatDao.fetchTTCByListOfIDs(tankIds);

  @override
  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC) =>
      wotStatDao.saveTTCList(listTTC);

  @override
  int getVehiclesTTCCount() => sharedPreferences.getInt(ttcCountInDb) ?? 0;

  @override
  void setVehiclesTtcCount(int ttcCount) =>
      sharedPreferences.setInt(ttcCountInDb, ttcCount);

  @override
  UserData? getSignedUser() {
    int? id = sharedPreferences.getInt(signedUserId);
    String? nickname = sharedPreferences.getString(signedUserNickname);
    String? accessToken = sharedPreferences.getString(signedUserToken);
    int? expiresAt = sharedPreferences.getInt(signedUserExpire);
    String? realm = sharedPreferences.getString(signedUserRealm);

    if (id == null ||
        nickname == null ||
        accessToken == null ||
        expiresAt == null ||
        realm == null) return null;

    return UserData(
      id: id,
      nickname: nickname,
      accessToken: accessToken,
      expiresAt: expiresAt,
      realm: realm,
    );
  }

  @override
  String getCurrentLng() => sharedPreferences.getString(lngKey) ?? notPicked;
}
