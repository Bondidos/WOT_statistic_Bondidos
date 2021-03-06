import 'package:equatable/equatable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private_info.dart';

abstract class AchievesState extends Equatable {
  const AchievesState();
}

class ErrorState extends AchievesState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingState extends AchievesState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadedDataState extends AchievesState {
  final List<StaggeredGridTile> achievesData;
  final bool isPrivateDataAllow;
  final UserNoPrivateInfo? userNoPrivateInfo;

  const LoadedDataState({
    required this.achievesData,
    required this.isPrivateDataAllow,
    this.userNoPrivateInfo,
  });

  @override
  List<Object?> get props => [achievesData];
}
