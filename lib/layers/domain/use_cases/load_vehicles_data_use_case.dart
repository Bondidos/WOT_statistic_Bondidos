import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/repositories/vehicles_repo.dart';

class LoadVehiclesDataUseCase {
  final VehiclesRepo repository;

  LoadVehiclesDataUseCase({required this.repository});

  Future<List<Vehicle>> execute() => repository.fetchUserVehicles();
}
