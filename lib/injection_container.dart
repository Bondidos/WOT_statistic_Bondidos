import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/repositories/settings_repo_impl.dart';
import 'package:wot_statistic/layers/data/repositories/sign_in_repo_impl.dart';
import 'package:wot_statistic/layers/data/sources/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_achieves_data.dart';
import 'package:wot_statistic/layers/domain/use_cases/sing_in_use_case.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/construct_db/shared.dart';
import 'package:wot_statistic/layers/local/data_sources/sources/drift_database/dao/dao.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

import 'layers/data/repositories/achieves_repo_impl.dart';
import 'layers/data/repositories/personal_data_repo_impl.dart';
import 'layers/data/repositories/search_user_repo_impl.dart';
import 'layers/data/repositories/vehicles_repo_impl.dart';
import 'layers/data/sources/local_data_source.dart';
import 'layers/domain/repositories/achieves_repo.dart';
import 'layers/domain/repositories/personal_data_repo.dart';
import 'layers/domain/repositories/search_user_repo.dart';
import 'layers/domain/repositories/settings_repo.dart';
import 'layers/domain/repositories/sign_in_repo.dart';
import 'layers/domain/repositories/vehicles_repo.dart';
import 'layers/domain/use_cases/load_personal_data.dart';
import 'layers/domain/use_cases/load_vehicles_data.dart';
import 'layers/domain/use_cases/remove_user_use_case.dart';
import 'layers/domain/use_cases/save_user_use_case.dart';
import 'layers/domain/use_cases/search_user_use_case.dart';
import 'layers/domain/use_cases/set_lng_use_case.dart';
import 'layers/domain/use_cases/set_theme_use_case.dart';
import 'layers/domain/use_cases/subscribe_lng_use_case.dart';
import 'layers/domain/use_cases/subscribe_users_use_case.dart';
import 'layers/domain/use_cases/set_realm_pref_use_case.dart';
import 'layers/domain/use_cases/subscribe_realm_use_case.dart';
import 'layers/domain/use_cases/subscribe_theme_use_case.dart';
import 'layers/local/data_sources/local_source_impl/local_datasource_impl.dart';
import 'layers/local/data_sources/sources/drift_database/database/database.dart';
import 'layers/presentation/search_user/bloc/search_user_cubit.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';
import 'layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'layers/remote/remote_source_impl/remote_source_impl.dart';
import 'layers/remote/sources/wot_api_client.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerFactory(() => SettingsCubit(
        subscribeTheme: inj(),
        setTheme: inj(),
        subscribeLng: inj(),
        setLngUseCase: inj(),
      ));

  inj.registerFactory(() => SingInCubit(
        saveUser: inj(),
        subscribeUsers: inj(),
        subscribeRealm: inj(),
        setRealm: inj(),
        removeUserUseCase: inj(),
        signIn: inj(),
      ));

  inj.registerFactory(() => PersonalDataCubit(loadData: inj()));
  inj.registerFactory(() => VehiclesDataCubit(loadVehicles: inj()));
  inj.registerFactory(() => AchievesDataCubit(loadAchieves: inj()));
  inj.registerFactory(() => SearchUserCubit(searchUser: inj(), signIn: inj()));

  inj.registerFactory(() => SearchUserUseCase(repository: inj()));
  inj.registerFactory(() => LoadAchievesData(repository: inj()));
  inj.registerFactory(() => LoadVehiclesData(repository: inj()));
  inj.registerFactory(() => SubscribeThemeUseCase(repository: inj()));
  inj.registerFactory(() => SaveUserUseCase(repository: inj()));
  inj.registerFactory(() => SubscribeUsers(repository: inj()));
  inj.registerFactory(() => SubscribeRealm(repository: inj()));
  inj.registerFactory(() => SetRealmUseCase(repository: inj()));
  inj.registerFactory(() => RemoveUserUseCase(repository: inj()));
  inj.registerFactory(() => SetThemeUseCase(repository: inj()));
  inj.registerFactory(() => LoadPersonalData(repository: inj()));
  inj.registerFactory(() => SingInUseCase(repository: inj()));
  inj.registerFactory(() => SubscribeLng(repository: inj()));
  inj.registerFactory(() => SetLngUseCase(repository: inj()));

  inj.registerLazySingleton<SignInRepo>(() => SignInRepoImpl(
        baseOptions: inj(),
        localSource: inj(),
        remoteSource: inj(),
      ));

  inj.registerLazySingleton<SettingsRepo>(
      () => SettingsRepoImpl(localSource: inj()));

  inj.registerLazySingleton<PersonalDataRepo>(() => PersonalDataRepoImpl(
        localSource: inj(),
        remoteSource: inj(),
      ));

  inj.registerLazySingleton<SearchUserRepo>(
      () => SearchUserRepoImpl(remoteSource: inj()));

  inj.registerLazySingleton<VehiclesRepo>(
      () => VehiclesRepoImpl(remoteSource: inj(), localSource: inj()));

  inj.registerLazySingleton<AchievesRepo>(
      () => AchievesRepoImpl(remoteSource: inj(), localSource: inj()));

  inj.registerFactory<RemoteDataSource>(
      () => RemoteSourceImpl(wotClient: inj()));

  inj.registerFactory<LocalDataSource>(() => LocalDataSourceImpl(
        sharedPreferences: inj(),
        wotStatDao: inj(),
      ));

  inj.registerLazySingleton<WotStatDao>(() => WotStatDao(inj()));

  inj.registerLazySingleton<WotClient>(() => WotClient(inj()));

  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final WotStatDatabase driftDatabase = constructDb();
  inj.registerSingleton<BaseOptions>(BaseOptions());
  final Dio dio = Dio(inj())..interceptors.add(LogInterceptor());
  inj.registerFactory(() => dio);
  inj.registerFactory(() => sharedPref);
  inj.registerFactory(() => driftDatabase);
}
