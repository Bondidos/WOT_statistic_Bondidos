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
