import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/sources/remoute_data_source.dart';
import 'package:wot_statistic/layers/domain/use_cases/sing_in_use_case.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/construct_db/shared.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/dao/dao.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';
import 'package:wot_statistic/layers/remoute/remout_source_impl/remoute_source_impl.dart';
import 'package:wot_statistic/layers/remoute/sources/wot_api_client.dart';

import 'layers/data/repositories/repository_impl.dart';
import 'layers/data/sources/local_data_source.dart';
import 'layers/domain/repositories/repository.dart';
import 'layers/domain/use_cases/load_personal_data.dart';
import 'layers/domain/use_cases/remove_user_use_case.dart';
import 'layers/domain/use_cases/save_user_use_case.dart';
import 'layers/domain/use_cases/set_theme_usecase.dart';
import 'layers/domain/use_cases/subscribe_users_use_case.dart';
import 'layers/domain/use_cases/set_realm_pref_use_case.dart';
import 'layers/domain/use_cases/subscribe_realm_use_case.dart';
import 'layers/domain/use_cases/subscribe_theme_use_case.dart';
import 'layers/local/data_sources/local_source_impl/local_datasource_impl.dart';
import 'layers/local/data_sources/sources/drift_database/database/database.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'layers/presentation/statistic_page/bloc/personal_data_cubit.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerFactory(
      () => SettingsCubit(subscribeTheme: inj(), setTheme: inj()));

  inj.registerFactory(() => SingInCubit(
        saveUser: inj(),
        subscribeUsers: inj(),
        subscribeRealm: inj(),
        setRealm: inj(),
        removeUserUseCase: inj(),
        singIn: inj(),
      ));

  inj.registerFactory(() => PersonalDataCubit(loadData: inj()));

  inj.registerFactory(() => SubscribeThemeUseCase(repository: inj()));
  inj.registerFactory(() => SaveUserUseCase(repository: inj()));
  inj.registerFactory(() => SubscribeUsers(repository: inj()));
  inj.registerFactory(() => SubscribeRealm(repository: inj()));
  inj.registerFactory(() => SetRealmUseCase(repository: inj()));
  inj.registerFactory(() => RemoveUserUseCase(repository: inj()));
  inj.registerFactory(() => SetThemeUseCase(repository: inj()));
  inj.registerFactory(() => LoadPersonalData(repository: inj()));
  inj.registerFactory(() => SingInUseCase(repository: inj()));

  inj.registerLazySingleton<Repository>(
      () => RepositoryImpl(localSource: inj(), remoteSource: inj()));

  inj.registerFactory<RemoteDataSource>(
      () => RemoteSourceImpl(wotClient: inj()));

  inj.registerFactory<LocalDataSource>(() => LocalDataSourceImpl(
        sharedPreferences: inj(),
        wotStatDao: inj(),
      ));

  inj.registerFactory<WotStatDao>(() => WotStatDao(inj()));

  inj.registerFactory<WotClient>(() => WotClient(inj()));

  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final WotStatDatabase driftDatabase = constructDb();
  final Dio dio = Dio();

  inj.registerFactory(() => dio);
  inj.registerFactory(() => sharedPref);
  inj.registerFactory(() => driftDatabase);
}
