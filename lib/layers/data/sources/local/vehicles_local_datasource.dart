import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc.dart';

abstract class VehiclesLocalDataSource {
  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds);

  String getCurrentLng();

  String getVehiclesCurrentLng();

  int getVehiclesTTCCount();

  void setVehiclesTtcCount(int ttcCount);

  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC);

  void setVehiclesCurrentLng(String lng);
}
