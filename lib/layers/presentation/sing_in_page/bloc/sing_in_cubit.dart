import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants/constants.dart';

import '../../../../common/errors/failure.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/remove_user_use_case.dart';
import '../../../domain/use_cases/save_user_use_case.dart';
import '../../../domain/use_cases/saved_users_by_realm.dart';
import '../../../domain/use_cases/set_realm_pref_use_case.dart';
import '../../../domain/use_cases/sync_realm_use_case.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  final SaveUserUseCase saveUser;
  final GetSavedUsersByRealm getUsersByRealm;
  final SyncRealmUseCase syncRealm;
  final SetRealmPrefUseCase setRealm;
  final RemoveUserUseCase removeUserUseCase;

  SingInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.getUsersByRealm,
    required this.syncRealm,
    required this.removeUserUseCase,
  }) : super(const SingInState(
            prevUsers: [], status: SingInStatus.initial, errorMessage: null)) {
    _initialize();
  }

  String _currentRealm = NOT_PICKED;
  String _currentUser = NOT_PICKED;

  String get currentUser => _currentUser;

  String get currentRealm => _currentRealm;

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
      _currentRealm = NOT_PICKED;
      return state.copyWith(
        status: SingInStatus.error,
        errorMessage: "Some storage error",
      );
    }, (realm) {
      _currentRealm = realm;
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
      _currentRealm = realm;
      emit(state.copyWith(status: SingInStatus.realmSynced));
    } else {
      emit(state.copyWith(
          status: SingInStatus.error, errorMessage: "Some storage error"));
    }
    emit(await _syncUsersByRealm());
  }

  void removeUser() async {
    emit(state.copyWith(status: SingInStatus.loading));
    if (_currentUser == NOT_PICKED) {
      emit(
        state.copyWith(
            status: SingInStatus.error, errorMessage: "Nothing to delete"),
      );
      return;
    }
    final User userToRemove =
        state.prevUsers.firstWhere((user) => user.nickname == _currentUser);
    _currentUser = NOT_PICKED;
    final bool result =
        await removeUserUseCase.execute(userToRemove, currentRealm);
    result
        ? emit(await _syncUsersByRealm())
        : emit(
            state.copyWith(
                status: SingInStatus.error, errorMessage: "Some storage error"),
          );
  }

  void setCurrentUser(String user) {
    emit(state.copyWith(status: SingInStatus.loading));
    _currentUser = user;
    emit(state.copyWith(status: SingInStatus.usersSynced));
  }

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
