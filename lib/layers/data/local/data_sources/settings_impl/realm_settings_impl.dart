import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';
import 'package:wot_statistic/common/constants.dart';

const realmKey = 'Realm';
const baseUrlEu = 'https://api.worldoftanks.eu';
const baseUrlCis = 'https://api.worldoftanks.ru';

class RealmSettingsImpl implements RealmSettings {
  final SharedPreferences sharedPreferences;
  final BaseOptions baseOptions;

  RealmSettingsImpl({
    required this.sharedPreferences,
    required this.baseOptions,
  }) {
    baseOptions.baseUrl = currentRealm == cis ? baseUrlCis : baseUrlEu;
  }

  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(notPicked);

  String get _readRealm => sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  String get currentRealm => sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  void setRealm(String realm) async {
    final bool result = await sharedPreferences.setString(realmKey, realm);
    if (!result) return;
    realmStream.add(realm);
    baseOptions.baseUrl = (realm == eu) ? baseUrlEu : baseUrlCis;
  }

  @override
  Stream<String> subscribeRealm() => realmStream..add(_readRealm);
}
