import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/found_user.dart';

enum SearchStatus { initial, loading, loaded }

class SearchUserState extends Equatable {
  final List<FoundUser> foundList;
  final SearchStatus status;

  const SearchUserState({required this.foundList, required this.status,});

  @override
  List<Object?> get props => [foundList, status];

  SearchUserState copyWith({List<FoundUser>? foundList, SearchStatus? status}) {
    return SearchUserState(
      foundList: foundList ?? this.foundList,
      status: status ?? this.status,
    );
  }
}
