part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInStateInit extends SignInState {
  const SignInStateInit();

  @override
  List<Object?> get props => [];
}

class SignInStateError extends SignInState {
  const SignInStateError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

class SignInStateLoading extends SignInState {
  const SignInStateLoading();

  @override
  List<Object?> get props => [];
}

class SignInStateLoaded extends SignInState {
  const SignInStateLoaded({required this.realm, required this.prevUsers});

  final String realm;
  final List<User> prevUsers;

  @override
  List<Object?> get props => [realm, prevUsers];
}

/*
//todo remove unused states
enum SingInStatus {
  initial,
  // usersSynced,
  realmSynced,
  error,
}

class SingInState extends Equatable {
  final List<User> prevUsers;
  final SingInStatus status;
  final String? errorMessage;
  final String realm;
  final User? currentUser;

  const SingInState(
      {required this.prevUsers,
      required this.status,
      required this.errorMessage,
      required this.realm,
      required this.currentUser});

  @override
  List<Object?> get props =>
      [prevUsers, status, errorMessage, realm, currentUser];

  SingInState copyWith(
      {List<User>? prevUsers,
      SingInStatus? status,
      String? errorMessage,
      String? realm,
      User? currentUser}) {
    return SingInState(
        prevUsers: prevUsers ?? this.prevUsers,
        status: status ?? this.status,
        errorMessage: errorMessage,
        realm: realm ?? this.realm,
        currentUser: currentUser);
  }
}*/
