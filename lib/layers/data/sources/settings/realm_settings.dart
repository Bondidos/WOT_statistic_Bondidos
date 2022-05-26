abstract class RealmSettings {
  String get currentRealm;

  void setRealm(String realm);

  Stream<String> subscribeRealm();
}
