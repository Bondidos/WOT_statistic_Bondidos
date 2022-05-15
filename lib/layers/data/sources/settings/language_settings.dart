abstract class LanguageSettings {
  void setAppLanguage(String language);

  String get appLanguage;

  Stream<String> subscribeAppLanguage();

  String get databaseCurrentLanguage;

  void setDatabaseCurrentLanguage(String language);
}
