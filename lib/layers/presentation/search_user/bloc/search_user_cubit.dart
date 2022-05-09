import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wot_statistic/layers/domain/entities/found_user.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/use_cases/search_user_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/view_found_user.dart';
import 'package:wot_statistic/layers/presentation/search_user/bloc/search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  final PublishSubject<String> searchStream = PublishSubject<String>();
  final SearchUserUseCase searchUser;
  final ViewFoundUser viewFoundUser;

  SearchUserCubit({
    required this.searchUser,
    required this.viewFoundUser,
  }) : super(const SearchUserState(
            status: SearchStatus.initial, foundList: [])) {
    init();
  }

  void init() {
    searchStream
        .debounce((event) => TimerStream(true, const Duration(seconds: 1)))
        .listen((search) async {
      try {
        final List<FoundUser> result = await searchUser.execute(search);
        Logger().d(result);
        emit(state.copyWith(
          foundList: result,
          status: SearchStatus.loaded,
        ));
      } catch (e) {
        emit(SearchError(
            message: e.toString(),
            status: SearchStatus.loaded,
            foundList: List.empty()));
      }
    });
  }

  void onTextChange(String search) => (search.length < 3)
      ? emit(state.copyWith(foundList: [], status: SearchStatus.initial))
      : searchStream.add(search);

  Future<void> viewUser(int index) async {
    FoundUser user = state.foundList[index];
    await viewFoundUser.execute(User.fromFoundUser(user));
  }
}
