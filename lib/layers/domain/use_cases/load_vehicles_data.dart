import '../entities/vehicles_data.dart';
import '../repositories/repository.dart';

class LoadVehiclesData {
  final Repository repository;
  LoadVehiclesData({required this.repository});

  Future<VehiclesData> execute() => repository.fetchVehiclesData();
}