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

/// This states read/save user's data into prefs
/// Init state, reads, previous state from SP:
/// if (null) todo use default realm (eu)
///     also todo dropping list displays: No saved Users
///     "Please Sing Up" (disable Sing In Button)
///     todo emit singing... -> await User from WebPAge
///     todo emit initState -> choose user and continue
/// else todo retrieve List<User> and display in Dropping list
///
///
/// */
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
  }) : super(const SingInState(prevUsers: [], status: SingInStatus.initial)) {
    _init();
  }

  late String _realm;

  void _init() async {
    emit(state.copyWith(status: SingInStatus.initializing));

    final Either<Failure, String> result = await syncRealm.execute();
    _realm = result.fold((l) {
      // EU Realm by Default
      setRealmPreference(EU);
      return EU;
    }, (r) => r);

    emit(state.copyWith(status: SingInStatus.initialized));
  }

  void setRealmPreference(String realm) async {
    bool result = await setRealm.execute(EU);
    result
        ? emit( state.copyWith(status: SingInStatus.initialized) )
        : emit(const ErrorState(message: "DataBase Error"));
  }

  void saveUserInToDataBase(User user) async {
    emit(const LoadingState());

    final bool result = await saveUser.execute(user, _realm);
    result
        ? emit(const LoadedState())
        : emit(const ErrorState(message: "User do not saved"));
  }

  void getSavedUsersByRealm() async {
    final Either<Failure, List<User>> result =
        await getUsersByRealm.execute(_realm);
    final SingInState themeState = result.fold(
            (l) => ErrorState(message: l.message!),
            (r) => null
    );
  }
}
