import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';

abstract class VehiclesRepo{
  Future<List<Vehicle>> fetchUserVehicles();
}