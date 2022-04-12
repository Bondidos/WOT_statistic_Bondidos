import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants/constants.dart';

import '../../../../common/errors/failure.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/remove_user_use_case.dart';
import '../../../domain/use_cases/save_user_use_case.dart';
import '../../../domain/use_cases/subscribe_users_use_case.dart';
import '../../../domain/use_cases/set_realm_pref_use_case.dart';
import '../../../domain/use_cases/subscribe_realm_use_case.dart';

part 'sing_in_state.dart';

class SingInCubit extends Cubit<SingInState> {
  final SaveUserUseCase saveUser;
  final SubscribeUsers subscribeUsers;
  final SubscribeRealm subscribeRealm;
  final SetRealmUseCase setRealm;
  final RemoveUserUseCase removeUserUseCase;

  StreamSubscription? _subscriptionUsers;
  StreamSubscription? _subscriptionRealm;

  SingInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.subscribeUsers,
    required this.subscribeRealm,
    required this.removeUserUseCase,
  }) : super(const SingInState(
            prevUsers: [], status: SingInStatus.initial, errorMessage: null)) {
    _initialize();

  }
  void _initialize() {
    _subscriptionUsers = subscribeUsers.execute()
        .listen((event) {

      emit(  state.copyWith(
          status: SingInStatus.usersSynced, prevUsers: event),
      );
    });

    _subscriptionRealm = subscribeRealm.execute()
        .listen((event) {
      if(event == NOT_PICKED){
        setRealm.execute(EU);
      }
      _currentRealm = event;
      /**
          if(_currentRealm != event){

          }
       * */
      emit(  state.copyWith(
          status: SingInStatus.realmSynced),
      );
    });
  }


  String _currentRealm = NOT_PICKED;
  String _currentUserName = NOT_PICKED;

  String get currentUserName => _currentUserName;

  String get currentRealm => _currentRealm;

  User? get currentUser {
    emit(state.copyWith(status: SingInStatus.loading));

    if (_currentUserName == NOT_PICKED || state.prevUsers.isEmpty) {
      emit(
        state.copyWith(
            status: SingInStatus.error, errorMessage: "Please, sing up first"),
      );
      return null;
    }
    return state.prevUsers.firstWhere((user) => user.nickname == _currentUserName);
  }



















  /*void _initialize() async {
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
        await subscribeUsers.execute(currentRealm);
    return result.fold(
        (l) => state.copyWith(
            status: SingInStatus.error,
            errorMessage: "Some storage error"), (users) {
      _currentUserName = users.isNotEmpty
          ? users.first.nickname
          : NOT_PICKED;
      return state.copyWith(status: SingInStatus.usersSynced, prevUsers: users);
    });
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

    final User? userToRemove = currentUser;
    if(userToRemove == null) return;
    _currentUserName = state.prevUsers.isNotEmpty
        ? state.prevUsers.first.nickname
        : NOT_PICKED;
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
    _currentUserName = user;
    emit(state.copyWith(status: SingInStatus.usersSynced));
  }*/

  void saveUserInToDataBase(User user) async {
    emit(state.copyWith(status: SingInStatus.loading));

    final bool result = await saveUser.execute(user, currentRealm);
    /*result
        ? emit(await _syncUsersByRealm())
        : emit(
            state.copyWith(
                status: SingInStatus.error, errorMessage: "Some storage error"),
          );*/
  }

  @override
  Future<void> close(){
    //todo close all streams
    //todo repository close
    _subscriptionUsers?.cancel();
    _subscriptionRealm?.cancel();
    return super.close();
  }

}

