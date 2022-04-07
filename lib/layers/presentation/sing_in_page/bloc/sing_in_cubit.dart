
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/common/constants/constants.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/save_user_usecase.dart';

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
class SingInCubit extends Cubit<SingInState>{
  final SaveUserUseCase saveUser;

  SingInCubit({required this.saveUser})
      : super(const InitSingInState()){
    User user = const User(
        nickname: 'balda',
        accessToken: 'takoy sebe',
        expiresAt: 1161213214,
        id: '161151'
    );
    saveUser.execute(user, EU);
  }


}