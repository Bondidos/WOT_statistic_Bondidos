import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/use_cases/remove_user_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/save_user_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/sign_in_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/sign_out_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_users_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_realm_pref_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_realm_use_case.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SaveUserUseCase saveUser;
  final SubscribeUsersUseCase subscribeUsers;
  final SubscribeRealmUseCase subscribeRealm;
  final SetRealmUseCase setRealm;
  final RemoveUserUseCase removeUserUseCase;
  final SignInUseCase signIn;
  final SignOutUseCase signOut;

  StreamSubscription? _subscriptionUsers;
  StreamSubscription? _subscriptionRealm;

  SignInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.subscribeUsers,
    required this.subscribeRealm,
    required this.removeUserUseCase,
    required this.signIn,
    required this.signOut,
  }) : super(const SignInStateInit()) {
    _initialize();
  }

  void _initialize() {
    _subscriptionRealm = subscribeRealm.execute().listen((realm) {
      if (realm == notPicked) {
        setNewRealm(setDefaultRealm);
        return;
      }
      signOut.execute();
      _fetchPrevUsers(realm);
    });
  }

  String _currentRealm = notPicked;
  List<User> _prevUsers = [];
  User? _currentUser;

  User? get currentUser => _currentUser;

  String get currentRealm => _currentRealm;

  void _fetchPrevUsers(String realm) {
    if (_subscriptionUsers != null) _subscriptionUsers!.cancel();
    _subscriptionUsers = subscribeUsers
        .execute()
        .listen((list) => _newPrevUsersStatus(list, realm));
  }

  void _newPrevUsersStatus(List<User> usersList, String realm) {
    _currentRealm = realm;
    _prevUsers = usersList;
    _currentUser = (usersList.isEmpty) ? null : usersList.first;
    emit(SignInStateLoaded(realm: realm, prevUsers: usersList));
  }

  void error(String message) => emit(SignInStateError(errorMessage: message));

  void setNewRealm(String realm) {
    emit(const SignInStateLoading());
    setRealm.execute(realm);
  }

  void setCurrentUser(String userNickname) {
    emit(const SignInStateLoading());
    try {
      _currentUser = _prevUsers.firstWhere(
          (user) => user.nickname == userNickname,
          orElse: () => throw Exception(S.current.UserNotFound));
      emit(SignInStateLoaded(realm: _currentRealm, prevUsers: _prevUsers));
    } catch (e) {
      error(e.toString());
    }
  }

  void saveUserInToDataBase(User user) {
    emit(const SignInStateLoading());
    _currentUser = user;
    saveUser.execute(user);
  }

  List<String> get usersInCache => _prevUsers.map((e) => e.nickname).toList();

  void removeUser() async {
    emit(const SignInStateLoading());
    if (_currentUser == null) {
      error(S.current.NoUserToDelete);
    } else {
      await removeUserUseCase.execute(_currentUser!);
      _fetchPrevUsers(_currentRealm);
    }
  }

  Future<bool> signInAction() async {
    emit(const SignInStateLoading());
    if (_currentUser == null) {
      error(S.current.PleaseSignUp);
      return false;
    }
    if (DateTime.now().millisecondsSinceEpoch >
        _convertMillisecondsToSeconds(_currentUser!.expiresAt)) {
      error(S.current.TokenExpired);
      return false;
    }
    try {
      await signIn.execute(_currentUser!);
    } catch (e) {
      emit(SignInStateError(errorMessage: e.toString()));
      return false;
    }
    emit(SignInStateLoaded(realm: _currentRealm, prevUsers: _prevUsers));
    return true;
  }

  int _convertMillisecondsToSeconds(int milliseconds) => milliseconds * 1000;

  @override
  Future<void> close() {
    _subscriptionUsers?.cancel();
    _subscriptionRealm?.cancel();
    return super.close();
  }
}
