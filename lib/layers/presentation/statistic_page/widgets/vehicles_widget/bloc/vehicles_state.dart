import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';

abstract class VehiclesDataState extends Equatable{
  const VehiclesDataState();
}
class ErrorState extends VehiclesDataState{
  final String message;
  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
class LoadingState extends VehiclesDataState{
  const LoadingState();

  @override
  List<Object?> get props => [];
}
class LoadedDataState extends VehiclesDataState{
  final List<Vehicle> vehiclesData;
  const LoadedDataState({required this.vehiclesData});

  @override
  List<Object?> get props => [vehiclesData];
}