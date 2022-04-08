import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/layers/domain/usecases/saved_users_by_realm.dart';

import '../../../../common/errors/failure.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/save_user_usecase.dart';
import '../../../domain/usecases/set_realm_pref_usecase.dart';
import '../../../domain/usecases/sync_realm_usecase.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  final SaveUserUseCase saveUser;
  final GetSavedUsersByRealm getUsersByRealm;
  final SyncRealmUseCase syncRealm;
  final SetRealmPrefUseCase setRealm;

  SingInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.getUsersByRealm,
    required this.syncRealm,
  }) : super(const SingInState(
            prevUsers: [], status: SingInStatus.initial, errorMessage: null)) {
    _initialize();
  }

  late String currentRealm;

  void _initialize() async {
    emit(state.copyWith(status: SingInStatus.initializing));
    SingInState realmSyncResult = await _syncRealmPref();
    emit(realmSyncResult);

    SingInState syncUserResult = await _syncUsersByRealm();
    emit(syncUserResult);

    if (realmSyncResult.status == SingInStatus.realmSynced &&
        syncUserResult.status == SingInStatus.usersSynced) {
      emit(state.copyWith(status: SingInStatus.initialized));
    }
  }

  Future<SingInState> _syncRealmPref() async {
    final Either<Failure, String> result = await syncRealm.execute();
    return result.fold((l) {
      currentRealm = NOT_PICKED;
      return state.copyWith(
        status: SingInStatus.error,
        errorMessage: "Some storage error",
      );
    }, (realm) {
      currentRealm = realm;
      return state.copyWith(status: SingInStatus.realmSynced);
    });
  }

  Future<SingInState> _syncUsersByRealm() async {
    final Either<Failure, List<User>> result =
        await getUsersByRealm.execute(currentRealm);
    return result.fold(
        (l) => state.copyWith(
            status: SingInStatus.error, errorMessage: "Some storage error"),
        (users) =>
            state.copyWith(status: SingInStatus.usersSynced, prevUsers: users));
  }

  void setRealmPreference(String realm) async {
    emit(state.copyWith(status: SingInStatus.loading));

    bool result = await setRealm.execute(realm);
    if (result) {
      currentRealm = realm;
      emit(state.copyWith(status: SingInStatus.realmSynced));
    } else {
      emit(state.copyWith(
          status: SingInStatus.error, errorMessage: "Some storage error"));
    }
  }

  // todo add remove user option


  //todo move it to the sing up cubit/page
  void saveUserInToDataBase(User user) async {
    emit(state.copyWith(status: SingInStatus.loading));

    final bool result = await saveUser.execute(user, currentRealm);
    result
        ? emit(await _syncUsersByRealm())
        : emit(
            state.copyWith(
                status: SingInStatus.error, errorMessage: "Some storage error"),
          );
  }
}
