import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/remove_user_use_case.dart';
import '../../../domain/use_cases/save_user_use_case.dart';
import '../../../domain/use_cases/sing_in_use_case.dart';
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
  final SingInUseCase singIn;

  StreamSubscription? _subscriptionUsers;
  StreamSubscription? _subscriptionRealm;

  SingInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.subscribeUsers,
    required this.subscribeRealm,
    required this.removeUserUseCase,
    required this.singIn,
  }) : super(const SingInState(
            prevUsers: [],
            status: SingInStatus.initial,
            errorMessage: null,
            realm: NOT_PICKED,
            currentUser: null)) {
    _initialize();
  }

  void _initialize() {
    _subscriptionRealm = subscribeRealm.execute().listen((realm) {
      if (realm == NOT_PICKED) {
        setNewRealm(EU); // as default EU realm
        return;
      }
      if (_subscriptionUsers != null) _subscriptionUsers?.cancel();
      _subscriptionUsers =
          subscribeUsers.execute().listen((list) => _newPrevUsersStatus(list,realm));
    });
  }
  // todo refresh state after emitting error
  void _newPrevUsersStatus(List<User> list, String realm) => emit(
        state.copyWith(
            status: SingInStatus.realmSynced,
            prevUsers: list,
            realm: realm,
            currentUser: list.isNotEmpty ? list.first : null),
      );
  void error(String message) => emit(
    state.copyWith(
        status: SingInStatus.error, errorMessage: message),
  );

  void setNewRealm(String realm) => setRealm.execute(realm);

  void setCurrentUser(String userNickname) {
    final User newCurrentUser =
        state.prevUsers.firstWhere((user) => user.nickname == userNickname);
    emit(state.copyWith(currentUser: newCurrentUser));
  }

  void saveUserInToDataBase(User user) => saveUser.execute(user, state.realm);

  void removeUser() {
    state.currentUser == null
        ? error("No user to delete")
        : removeUserUseCase.execute(state.currentUser!, state.realm);
  }

  Future<bool>  validateUserToken() async {
    if(state.currentUser == null) {
      error('Please, sing up');
      return false;
    }
    if(DateTime.now().millisecondsSinceEpoch > state.currentUser!.expiresAt *1000){
      error('Token expired, please sing up');
      return false;
    }
    // todo token extension
    await singIn.execute(state.currentUser!, state.realm);
    return true;
  }

  @override
  Future<void> close() {
    _subscriptionUsers?.cancel();
    _subscriptionRealm?.cancel();
    return super.close();
  }
}
