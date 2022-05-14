import 'package:bloc/bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_vehicles_data.dart';

const int byDefault = 0;
const int byWins = 1;
const int byBattles = 2;
const int byMastery = 3;
const int byLvl = 4;
const String nationByDefault = "All";

class VehiclesDataCubit extends Cubit<VehiclesDataState> {
  final LoadVehiclesData loadVehicles;

  VehiclesDataCubit({required this.loadVehicles})
      : super(const LoadingState()) {
    fetchVehiclesData();
  }

  List<Vehicle> _vehicleList = [];

  List<Vehicle> get vehicleList => _vehicleList;
  List<Vehicle> sorted = [];
  int _sort = byDefault;
  String nationFilter = nationByDefault;

  Future<void> fetchVehiclesData() async {
    try {
      if (state is! LoadingState) emit(const LoadingState());
      _vehicleList = await loadVehicles.execute();
      sorted = vehicleList;
      _sortBy();
      _filterByNation();
      emit(LoadedDataState(vehiclesData: sorted));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() => fetchVehiclesData();

  void sortByLvl() {
    _sort = byLvl;
    _sortBy();
  }

  void sortByBattles() {
    _sort = byBattles;
    _sortBy();
  }

  void sortByWins() {
    _sort = byWins;
    _sortBy();
  }

  void sortByMastery() {
    _sort = byMastery;
    _sortBy();
  }

  void filterByNation(String nation) {
    nationFilter = nation;
    _filterByNation();
  }

  void _sortBy() {
    if (vehicleList.isEmpty) {
      emit(ErrorState(message: S.current.NoVehiclesToShow));
    }
    emit(const LoadingState());
    switch (_sort) {
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

  void _filterByNation() {
    if (nationFilter == nationByDefault) {
      sorted = vehicleList;
    } else {
      sorted = vehicleList
          .where((vehicle) => vehicle.nation == nationFilter.toLowerCase())
          .toList();
    }
    emit(LoadedDataState(vehiclesData: sorted));
  }

  double _calcWinPercent(int battles, int wins) => 100.0 / battles * wins;
}
