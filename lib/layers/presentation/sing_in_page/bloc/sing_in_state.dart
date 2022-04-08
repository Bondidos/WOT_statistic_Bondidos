part of 'sing_in_cubit.dart';

enum SingInStatus {
  initial,
  initializing,
  realmSynced,
  usersSynced,
  initialized,
  error,
  loading,
  loaded
}

class SingInState extends Equatable {
  final List<User> prevUsers;
  final SingInStatus status;
  final String? errorMessage;

  const SingInState(
      {required this.prevUsers,
      required this.status,
      required this.errorMessage});

  @override
  List<Object?> get props => [prevUsers, status, errorMessage];

  SingInState copyWith(
      {List<User>? prevUsers, SingInStatus? status, String? errorMessage}) {
    return SingInState(
      prevUsers: prevUsers ?? this.prevUsers,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/*abstract class SingInState extends Equatable {
  const SingInState();
}

class InitSingInState extends SingInState {
  const InitSingInState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends SingInState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedState extends SingInState {
  const LoadedState();

  @override
  List<Object?> get props => [];
}

class ErrorState extends SingInState {
  final String message;
  const ErrorState({required this.message});

  @override
  List<Object?> get props => [];
}*/
