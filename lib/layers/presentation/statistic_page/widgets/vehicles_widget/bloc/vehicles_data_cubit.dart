import 'package:bloc/bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_vehicles_data.dart';

const int byWins = 1;
const int byBattles = 2;
const int byMastery = 3;
const int byLvl = 4;

class VehiclesDataCubit extends Cubit<VehiclesDataState> {
  final LoadVehiclesData loadVehicles;

  VehiclesDataCubit({required this.loadVehicles})
      : super(const LoadingState()) {
    fetchVehiclesData();
  }

  List<Vehicle> _vehicleList = [];
  List<Vehicle> get vehicleList => _vehicleList;
  List<Vehicle> sorted = [];

  Future<void> fetchVehiclesData() async {
    try {
      _vehicleList = await loadVehicles.execute();
      sorted = vehicleList;
      emit(LoadedDataState(vehiclesData: _vehicleList));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() => fetchVehiclesData();

  void sortByLvl() => _sortBy(sort: byLvl);

  void sortByBattles() => _sortBy(sort: byBattles);

  void sortByWins() => _sortBy(sort: byWins);

  void sortByMastery() => _sortBy(sort: byMastery);

  void filterByNation(String nation) => _filterByNation(nation: nation);

  void _sortBy({required int sort}) {
    if (vehicleList.isEmpty) {
      emit(const ErrorState(message: 'No vehicles to show'));
    }
    emit(const LoadingState());
    switch (sort) {
      case byLvl:
        sorted.sort((a, b) => b.battles.compareTo(a.battles));
        sorted.sort((a, b) => b.tier.compareTo(a.tier));
        break;
      case byMastery:
        sorted.sort((a, b) => b.battles.compareTo(a.battles));
        sorted.sort((a, b) => b.markOfMastery.compareTo(a.markOfMastery));
        break;
      case byWins:
        sorted.sort((a, b) => _calcWinPercent(b.battles, b.wins)
            .compareTo(_calcWinPercent(a.battles, a.wins)));
        break;
      case byBattles:
        sorted.sort((a, b) => b.battles.compareTo(a.battles));
        break;
    }
    emit(LoadedDataState(vehiclesData: sorted));
  }

  void _filterByNation({required String nation}) {
    if(nation == 'All') {
      sorted = vehicleList;
    } else {
      sorted = vehicleList
          .where((vehicle) => vehicle.nation == nation.toLowerCase())
          .toList();
    }
    emit(LoadedDataState(vehiclesData: sorted));
  }

  double _calcWinPercent(int battles, int wins) => 100.0 / battles * wins;
}
