part of 'personal_data_cubit.dart';

abstract class PersonalDataState extends Equatable{
  const PersonalDataState();
}
class ErrorState extends PersonalDataState{
  final String message;
  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LoadingState extends PersonalDataState{
  const LoadingState();

  @override
  List<Object?> get props => [];
}
class LoadedDataState extends PersonalDataState{
  final PersonalData personalData;
  const LoadedDataState({required this.personalData});

  @override
  List<Object?> get props => [personalData];
}