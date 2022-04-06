
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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



  SingInCubit(SingInState initialState) : super(initialState);

}