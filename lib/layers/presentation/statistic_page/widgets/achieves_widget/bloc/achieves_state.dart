import 'package:equatable/equatable.dart';

import '../../../../../data/models/remote/achievements_data/achievement_data.dart';

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
  final List<AchievementData> achievesData;

  const LoadedDataState({required this.achievesData});

  @override
  List<Object?> get props => [achievesData];
}
