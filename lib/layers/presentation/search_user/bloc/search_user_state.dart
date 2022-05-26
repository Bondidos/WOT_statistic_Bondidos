import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';

enum SearchStatus { initial, loading, loaded }

class SearchUserState extends Equatable {
  final List<UserNoPrivate> foundList;
  final SearchStatus status;

  const SearchUserState({
    required this.foundList,
    required this.status,
  });

  @override
  List<Object?> get props => [foundList, status];

  SearchUserState copyWith({List<UserNoPrivate>? foundList, SearchStatus? status}) {
    return SearchUserState(
      foundList: foundList ?? this.foundList,
      status: status ?? this.status,
    );
  }
}

class SearchError extends SearchUserState {
  const SearchError({
    required List<UserNoPrivate> foundList,
    required SearchStatus status,
    required this.message,
  }) : super(foundList: foundList, status: status);
  final String message;
}
