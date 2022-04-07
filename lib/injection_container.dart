import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/domain/usecases/save_user_usecase.dart';
import 'package:wot_statistic/layers/local/datasources/sqflite/sqflite.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import 'layers/data/repositories/repository_impl.dart';
import 'layers/data/sources/local_data_source.dart';
import 'layers/domain/repositories/repository.dart';
import 'layers/domain/usecases/saved_users_by_realm.dart';
import 'layers/domain/usecases/set_realm_pref_usecase.dart';
import 'layers/domain/usecases/sync_realm_usecase.dart';
import 'layers/domain/usecases/sync_theme_usecase.dart';
import 'layers/local/datasources/shared_preferences/local_datasource_impl.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerFactory(() => SettingsCubit(sync: inj()));
  inj.registerFactory(() => SingInCubit(
        saveUser: inj(),
        getUsersByRealm: inj(),
        syncRealm: inj(),
        setRealm: inj(),
      ));

  inj.registerFactory(() => SyncThemeUseCase(repository: inj()));
  inj.registerFactory(() => SaveUserUseCase(repository: inj()));
  inj.registerFactory(() => GetSavedUsersByRealm(repository: inj()));
  inj.registerFactory(() => SyncRealmUseCase(repository: inj()));
  inj.registerFactory(() => SetRealmPrefUseCase(repository: inj()));

  inj.registerLazySingleton<Repository>(
      () => RepositoryImpl(localSource: inj()));

  inj.registerFactory<LocalDataSource>(() => LocalDataSourceImpl(
        sharedPreferences: inj(),
        sqfLite: inj(),
      ));

  final sharedPref = await SharedPreferences.getInstance();
  final sqfLite = DatabaseHelper.instance;
  inj.registerFactory(() => sharedPref);
  inj.registerFactory(() => sqfLite);
}
