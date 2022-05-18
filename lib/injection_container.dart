import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wot_statistic/layers/data/local/achieves_local_datasource_impl.dart';
import 'package:wot_statistic/layers/data/local/personal_data_local_source.dart';
import 'package:wot_statistic/layers/data/local/settings_data_source_impl.dart';
import 'package:wot_statistic/layers/data/local/vehicles_local_datasource_impl.dart';
import 'package:wot_statistic/layers/data/repositories/settings_repo_impl/settings_repo_impl.dart';
import 'package:wot_statistic/layers/data/repositories/sign_in_repo_impl/sign_in_repo_impl.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_achieves_data.dart';
import 'package:wot_statistic/layers/domain/use_cases/sign_in_use_case.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';
import 'layers/data/local/data_sources/settings_impl/database_settings_impl.dart';
import 'layers/data/local/data_sources/settings_impl/language_settings_impl.dart';
import 'layers/data/local/data_sources/settings_impl/realm_settings_impl.dart';
import 'layers/data/local/data_sources/settings_impl/theme_settings_impl.dart';
import 'layers/data/local/data_sources/settings_impl/user_settings_impl.dart';
import 'layers/data/local/search_user_local_impl.dart';
import 'layers/data/local/sign_local_datasource_impl.dart';
import 'layers/data/remote/remote_source_impl/api_constants.dart';
import 'layers/data/remote/remote_source_impl/remote_source_impl.dart';
import 'layers/data/remote/sources/api_client.dart';
import 'layers/data/repositories/achieve_repo_impl/achieves_repo_impl.dart';
import 'layers/data/repositories/personal_data_repo_impl/personal_data_repo_impl.dart';
import 'layers/data/repositories/search_user_repo_impl/search_user_repo_impl.dart';
import 'layers/data/repositories/vehicles_repo_impl/vehicles_repo_impl.dart';
import 'layers/data/sources/local/achieves_local_datasource.dart';
import 'layers/data/sources/local/personal_data_local_source.dart';
import 'layers/data/sources/local/search_user_local_datasource.dart';
import 'layers/data/sources/local/settings_data_source.dart';
import 'layers/data/sources/local/sign_local_datasource.dart';
import 'layers/data/sources/local/vehicles_local_datasource.dart';
import 'layers/data/sources/settings/database_settings.dart';
import 'layers/data/sources/settings/language_settings.dart';
import 'layers/data/sources/settings/realm_settings.dart';
import 'layers/data/sources/settings/theme_settings.dart';
import 'layers/data/sources/settings/user_settings.dart';
import 'layers/domain/repositories/achieves_repo.dart';
import 'layers/domain/repositories/personal_data_repo.dart';
import 'layers/domain/repositories/search_user_repo.dart';
import 'layers/domain/repositories/settings_repo.dart';
import 'layers/domain/repositories/sign_in_repo.dart';
import 'layers/domain/repositories/vehicles_repo.dart';
import 'layers/domain/use_cases/load_personal_data.dart';
import 'layers/domain/use_cases/load_user_no_private.dart';
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
import 'layers/domain/use_cases/view_found_user.dart';
import 'layers/presentation/search_user/bloc/search_user_cubit.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';
import 'layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'layers/data/local/data_sources/drift_database/database.dart';

final inj = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  inj.registerFactory(() => SettingsCubit(
        subscribeTheme: inj(),
        setTheme: inj(),
        subscribeLng: inj(),
        setLngUseCase: inj(),
      ));

  inj.registerFactory(() => SignInCubit(
        saveUser: inj(),
        subscribeUsers: inj(),
        subscribeRealm: inj(),
        setRealm: inj(),
        removeUserUseCase: inj(),
        signIn: inj(),
      ));

  inj.registerFactory(() => PersonalDataCubit(loadData: inj()));
  inj.registerFactory(() => VehiclesDataCubit(loadVehicles: inj()));
  inj.registerFactory(() => AchievesDataCubit(
        loadAchieves: inj(),
        loadUserNoPrivateInfo: inj(),
      ));
  inj.registerFactory(
      () => SearchUserCubit(searchUser: inj(), viewFoundUser: inj()));

  inj.registerFactory(() => LoadUserNoPrivateInfo(repository: inj()));
  inj.registerFactory(() => ViewFoundUser(repository: inj()));
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
  inj.registerFactory(() => SignInUseCase(repository: inj()));
  inj.registerFactory(() => SubscribeLng(repository: inj()));
  inj.registerFactory(() => SetLngUseCase(repository: inj()));

  // REPOSITORIES
  inj.registerLazySingleton<SignInRepo>(() => SignInRepoImpl(
        // baseOptions: inj(),
        remoteSource: inj(),
        signLocalSource: inj(),
      ));

  inj.registerLazySingleton<SettingsRepo>(
      () => SettingsRepoImpl(settingsSource: inj()));

  inj.registerLazySingleton<PersonalDataRepo>(() => PersonalDataRepoImpl(
        personalDataLocalSource: inj(),
        remoteSource: inj(),
        // baseOptions: inj(),
      ));

  inj.registerLazySingleton<SearchUserRepo>(() =>
      SearchUserRepoImpl(remoteSource: inj(), searchUserLocalSource: inj()));

  inj.registerLazySingleton<VehiclesRepo>(() => VehiclesRepoImpl(
        remoteSource: inj(),
        vehiclesLocalSource: inj(),
      ));

  inj.registerLazySingleton<AchievesRepo>(() => AchievesRepoImpl(
        remoteSource: inj(),
        achievesLocalDataSource: inj(),
      ));

  // SOURCES
  inj.registerFactory<SearchUserLocalSource>(() => SearchUserLocalSourceImpl(
        userSettings: inj(),
      ));

  inj.registerFactory<SettingsDataSource>(() => SettingsDataSourceImpl(
        languageSettings: inj(),
        themeSettings: inj(),
      ));

  inj.registerFactory<AchievesLocalDataSource>(
      () => AchievesLocalDataSourceImpl(
            achievementDao: inj(),
            languageSettings: inj(),
            databaseSettings: inj(),
          ));

  inj.registerFactory<RemoteDataSource>(() => RemoteSourceImpl(
        apiClient: inj(),
        apiConstants: inj(),
      ));

  inj.registerFactory<SignLocalDataSource>(() => SignLocalDataSourceImpl(
        userDao: inj(),
        userSettings: inj(),
        realmSettings: inj(),
      ));

  inj.registerFactory<PersonalDataLocalSource>(
      () => PersonalDataLocalSourceImpl(
            userDao: inj(),
            userSettings: inj(),
            realmSettings: inj(),
          ));

  inj.registerFactory<VehiclesLocalDataSource>(
      () => VehiclesLocalDataSourceImpl(
            vehicleTtcDao: inj(),
            databaseSettings: inj(),
            languageSettings: inj(),
          ));
  inj.registerLazySingleton<ThemeSettings>(() => ThemeSettingsImpl(
        sharedPreferences: inj(),
      ));
  inj.registerLazySingleton<UserSettings>(() => UserSettingsImpl(
        sharedPreferences: inj(),
      ));
  inj.registerLazySingleton<RealmSettings>(() => RealmSettingsImpl(
        sharedPreferences: inj(),
        baseOptions: inj(),
      ));
  inj.registerLazySingleton<LanguageSettings>(() => LanguageSettingsImpl(
        sharedPreferences: inj(),
      ));
  inj.registerLazySingleton<DatabaseSettings>(() => DatabaseSettingsImpl(
        sharedPreferences: inj(),
      ));

  inj.registerLazySingleton<UserDao>(() => UserDao(inj()));
  inj.registerLazySingleton<VehicleTtcDao>(() => VehicleTtcDao(inj()));
  inj.registerLazySingleton<AchievementDao>(() => AchievementDao(inj()));

  inj.registerLazySingleton<ApiClient>(() => ApiClient(inj()));

  inj.registerFactory<ApiConstants>(() => ApiConstants(userSettings: inj()));

  inj.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  inj.registerSingleton<BaseOptions>(BaseOptions());

  final Database driftDatabase = constructDb();
  final Dio dio = Dio(inj())..interceptors.add(LogInterceptor());
  inj.registerFactory(() => dio);
  inj.registerFactory(() => driftDatabase);
}
