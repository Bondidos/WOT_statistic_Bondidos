import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layers/data/repositories/repository_impl.dart';
import 'layers/data/sources/local_data_source.dart';
import 'layers/domain/repositories/repository.dart';
import 'layers/domain/usecases/sync_theme_usecase.dart';
import 'layers/local/datasources/shared_preferences/local_datasource_impl.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerLazySingleton<SettingsCubit>(() => SettingsCubit(sync: inj()));

  inj.registerFactory(() => SyncThemeUseCase(repository: inj()));

  inj.registerLazySingleton<Repository>(() => RepositoryImpl(localSource: inj()));

  inj.registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: inj()));

  final sharedPref = await SharedPreferences.getInstance();
  inj.registerFactory(() => sharedPref);
}
