abstract class LanguageSettings {
  void setAppLanguage(String language);

  String get appLanguage;

  Stream<String> subscribeAppLanguage();

  String get vehiclesCurrentLanguage;

  String get achievesCurrentLanguage;

  void setVehiclesCurrentLanguage(String language);

  void setAchievesCurrentLanguage(String language);
}
