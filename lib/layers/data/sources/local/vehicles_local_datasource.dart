import 'package:wot_statistic/layers/data/models/remote/vehicles_data/vehicles_data_ttc_api.dart';

abstract class VehiclesLocalDataSource {
  Future<int> saveTTCList(List<VehiclesDataTTC> listTTC);

  Future<List<VehiclesDataTTC>> fetchTTCByListOfIDs(List<int> tankIds);

  bool get isVehiclesDBAndAppLanguagesSame;

  int get vehiclesTTCCount;

  void setVehiclesTtcCount(int ttcCount);

  void setVehiclesCurrentLanguage();
}
