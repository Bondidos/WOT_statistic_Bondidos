part of 'sing_in_cubit.dart';
//todo remove unused states
enum SingInStatus {
  initial,
  usersSynced,
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
        errorMessage: errorMessage ?? this.errorMessage,
        realm: realm ?? this.realm,
        currentUser: currentUser ?? this.currentUser);
  }
}
