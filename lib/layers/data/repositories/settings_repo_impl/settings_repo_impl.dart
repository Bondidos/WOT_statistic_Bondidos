import 'package:wot_statistic/layers/data/sources/local/settings_data_source.dart';
import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo{
  final SettingsDataSource settingsSource;

  const SettingsRepoImpl({
    required this.settingsSource,
  });

  @override
  void setLng(String language) => settingsSource.setLanguage(language);

  @override
  void setTheme(String theme) => settingsSource.setTheme(theme);

  @override
  Stream<String> get subscribeLng => settingsSource.subscribeLng();

  @override
  Stream<String> get subscribeTheme => settingsSource.subscribeTheme();
}