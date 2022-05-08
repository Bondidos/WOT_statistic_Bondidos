import 'package:wot_statistic/layers/domain/repositories/settings_repo.dart';

import '../sources/local_data_source.dart';

class SettingsRepoImpl implements SettingsRepo{
  final LocalDataSource localSource; //todo make separate source

  const SettingsRepoImpl({
    required this.localSource,
  });

  @override
  void setLng(String lng) => localSource.setLng(lng);

  @override
  void setTheme(String theme) => localSource.setTheme(theme);

  @override
  Stream<String> get subscribeLng => localSource.subscribeLng();

  @override
  Stream<String> get subscribeTheme => localSource.subscribeTheme();
}