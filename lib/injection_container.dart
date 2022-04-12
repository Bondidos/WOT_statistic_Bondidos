import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/dao/dao.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import 'layers/data/repositories/repository_impl.dart';
import 'layers/data/sources/local_data_source.dart';
import 'layers/domain/repositories/repository.dart';
import 'layers/domain/use_cases/remove_user_use_case.dart';
import 'layers/domain/use_cases/save_user_use_case.dart';
import 'layers/domain/use_cases/subscribe_users_use_case.dart';
import 'layers/domain/use_cases/set_realm_pref_use_case.dart';
import 'layers/domain/use_cases/subscribe_realm_use_case.dart';
import 'layers/domain/use_cases/sync_theme_use_case.dart';
import 'layers/local/data_sources/local_source_impl/local_datasource_impl.dart';
import 'layers/local/data_sources/sources/drift_database/construct_db/mobile.dart';
import 'layers/local/data_sources/sources/drift_database/database/database.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerFactory(() => SettingsCubit(sync: inj()));
  inj.registerFactory(() => SingInCubit(
        saveUser: inj(),
        subscribeUsers: inj(),
        subscribeRealm: inj(),
        setRealm: inj(),
        removeUserUseCase: inj(),
      ));

  inj.registerFactory(() => SyncThemeUseCase(repository: inj()));
  inj.registerFactory(() => SaveUserUseCase(repository: inj()));
  inj.registerFactory(() => SubscribeUsers(repository: inj()));
  inj.registerFactory(() => SubscribeRealm(repository: inj()));
  inj.registerFactory(() => SetRealmUseCase(repository: inj()));
  inj.registerFactory(() => RemoveUserUseCase(repository: inj()));

  inj.registerLazySingleton<Repository>(
      () => RepositoryImpl(localSource: inj()));

  inj.registerFactory<LocalDataSource>(() => LocalDataSourceImpl(
        sharedPreferences: inj(),
        wotStatDao: inj(),
      ));

  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final WotStatDatabase driftDatabase = constructDb();
  final WotStatDao wotStatDao = WotStatDao(driftDatabase);
  inj.registerFactory(() => sharedPref);
  inj.registerFactory(() => wotStatDao);
}
