import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/achieves.dart';

abstract class AchievesState extends Equatable{
  const AchievesState();
}
class ErrorState extends AchievesState{
  final String message;
  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LoadingState extends AchievesState{
  const LoadingState();

  @override
  List<Object?> get props => [];
}
class LoadedDataState extends AchievesState{
  final List<Achieve> achievesData;
  const LoadedDataState({required this.achievesData});

  @override
  List<Object?> get props => [achievesData];
}