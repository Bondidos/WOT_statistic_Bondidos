import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/settings/realm_settings.dart';

const notPicked = "Not Picked";
const realmKey = 'Realm';

class RealmSettingsImpl implements RealmSettings {
  final SharedPreferences sharedPreferences;

  RealmSettingsImpl({
    required this.sharedPreferences,
  });

  BehaviorSubject<String> realmStream = BehaviorSubject.seeded(notPicked);

  String get _readRealm => sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  String get currentRealm => sharedPreferences.getString(realmKey) ?? notPicked;

  @override
  void setRealm(String realm) async {
    final bool result = await sharedPreferences.setString(realmKey, realm);
    if (!result) return;
    realmStream.add(realm);
  }

  @override
  Stream<String> subscribeRealm() => realmStream..add(_readRealm);
}
