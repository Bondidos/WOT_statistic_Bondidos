import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wot_statistic/common/constants/constants.dart';
import '../../../../common/theme/text_styles.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/remove_user_use_case.dart';
import '../../../domain/use_cases/save_user_use_case.dart';
import '../../../domain/use_cases/sing_in_use_case.dart';
import '../../../domain/use_cases/subscribe_users_use_case.dart';
import '../../../domain/use_cases/set_realm_pref_use_case.dart';
import '../../../domain/use_cases/subscribe_realm_use_case.dart';

part 'sign_in_state.dart';

class SingInCubit extends Cubit<SignInState> {
  final SaveUserUseCase saveUser;
  final SubscribeUsers subscribeUsers;
  final SubscribeRealm subscribeRealm;
  final SetRealmUseCase setRealm;
  final RemoveUserUseCase removeUserUseCase;
  final SingInUseCase signIn;

  StreamSubscription? _subscriptionUsers;
  StreamSubscription? _subscriptionRealm;

  SingInCubit({
    required this.setRealm,
    required this.saveUser,
    required this.subscribeUsers,
    required this.subscribeRealm,
    required this.removeUserUseCase,
    required this.signIn,
  }) : super(const SignInStateInit()) {
    _initialize();
  }

  void _initialize() {
    _subscriptionRealm = subscribeRealm.execute().listen((realm) {
      if (realm == NOT_PICKED) {
        setNewRealm(EU); // as default EU realm
        return;
      }
      _fetchPrevUsers(realm);
    });
  }

  String _currentRealm = NOT_PICKED;
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
          orElse: () => throw Exception('User not found'));
      emit(SignInStateLoaded(realm: _currentRealm, prevUsers: _prevUsers));
    } catch (e) {
      error(e.toString());
    }
  }

  void saveUserInToDataBase(User user) {
    emit(const SignInStateLoading());
    _currentUser = user;
    saveUser.execute(user, _currentRealm);
  }

  List<String> get usersInCache => _prevUsers.map((e) => e.nickname).toList();

  List<DropdownMenuItem<String>> createDropDownItem(BuildContext context) {
    final List<DropdownMenuItem<String>> result = [];
    for (int index = 0; index < usersInCache.length; index++) {
      result.add(_generateDropdownItem(index, context));
    }
    return result;
  }

  DropdownMenuItem<String> _generateDropdownItem(
      int index, BuildContext context) {
    return DropdownMenuItem<String>(
      value: usersInCache[index],
      child: Text(
        usersInCache[index],
        maxLines: 1,
        style: onPrimaryTitle(context),
      ),
    );
  }

  void removeUser() async {
    emit(const SignInStateLoading());
    if (_currentUser == null) {
      error("No user to delete");
    } else {
      await removeUserUseCase.execute(_currentUser!, _currentRealm);
      _fetchPrevUsers(_currentRealm);
    }
  }

  Future<bool> signInAction() async {
    emit(const SignInStateLoading());
    if (_currentUser == null) {
      error('Please, sign up');
      return false;
    }
    if (DateTime.now().millisecondsSinceEpoch >
        _currentUser!.expiresAt * 1000) {
      error('Token expired, please sign up');
      return false;
    }
    // todo token extension
    await signIn.execute(_currentUser!, _currentRealm);
    emit(SignInStateLoaded(realm: _currentRealm, prevUsers: _prevUsers));
    return true;
  }

  @override
  Future<void> close() {
    _subscriptionUsers?.cancel();
    _subscriptionRealm?.cancel();
    return super.close();
  }
}
