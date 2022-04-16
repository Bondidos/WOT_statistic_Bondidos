part of 'personal_data_cubit.dart';

abstract class PersonalDataStatus extends Equatable{
  const PersonalDataStatus();
}
class ErrorStatus extends PersonalDataStatus{
  final String message;
  const ErrorStatus({required this.message});

  @override
  List<Object?> get props => [message];
}
class LoadingStatus extends PersonalDataStatus{
  const LoadingStatus();

  @override
  List<Object?> get props => [];
}
class LoadedDataStatus extends PersonalDataStatus{
  final List<PersonalData> dataList;
  const LoadedDataStatus({required this.dataList});

  @override
  List<Object?> get props => [dataList];
}