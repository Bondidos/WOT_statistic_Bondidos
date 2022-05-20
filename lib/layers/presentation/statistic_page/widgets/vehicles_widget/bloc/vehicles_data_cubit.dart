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

  List<Vehicle> _fetchedVehicleList = [];

  List<Vehicle> get vehicleList => _fetchedVehicleList;
  List<Vehicle> sortedAndFilteredVehicleList = [];
  int _sortingOrder = byDefault;
  String nationFilter = nationByDefault;

  int get sortOrderCheck => _sortingOrder;

  void clearBufferList() => sortedAndFilteredVehicleList.clear();

  Future<void> fetchVehiclesData() async {
    try {
      if (state is! LoadingState) emit(const LoadingState());
      _fetchedVehicleList = await loadVehicles.execute();
      sortedAndFilteredVehicleList = vehicleList;
      _sortBy();
      _filterByNation();
      emit(LoadedDataState(vehiclesData: sortedAndFilteredVehicleList));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() => fetchVehiclesData();

  void sortBy(int sort) {
    _sortingOrder = sort;
    _sortBy();
  }

  void filterByNation(String nation) {
    nationFilter = nation;
    _filterByNation();
  }

  void _sortBy() {
    if (vehicleList.isEmpty) {
      emit(ErrorState(message: S.current.NoVehiclesToShow));
      return;
    }
    emit(const LoadingState());
    switch (_sortingOrder) {
      case byLvl:
        sortedAndFilteredVehicleList
            .sort((a, b) => b.battles.compareTo(a.battles));
        sortedAndFilteredVehicleList.sort((a, b) => b.tier.compareTo(a.tier));
        break;
      case byMastery:
        sortedAndFilteredVehicleList
            .sort((a, b) => b.battles.compareTo(a.battles));
        sortedAndFilteredVehicleList
            .sort((a, b) => b.markOfMastery.compareTo(a.markOfMastery));
        break;
      case byWins:
        sortedAndFilteredVehicleList.sort((a, b) =>
            _calcWinPercent(b.battles, b.wins)
                .compareTo(_calcWinPercent(a.battles, a.wins)));
        break;
      case byBattles:
        sortedAndFilteredVehicleList
            .sort((a, b) => b.battles.compareTo(a.battles));
        break;
    }
    emit(LoadedDataState(vehiclesData: sortedAndFilteredVehicleList));
  }

  void _filterByNation() {
    if (_fetchedVehicleList.isEmpty) {
      emit(ErrorState(message: S.current.NoVehiclesToShow));
      return;
    }
    if (nationFilter == nationByDefault) {
      sortedAndFilteredVehicleList = vehicleList;
    } else {
      sortedAndFilteredVehicleList = vehicleList
          .where((vehicle) => vehicle.nation == nationFilter.toLowerCase())
          .toList();
    }
    emit(LoadedDataState(vehiclesData: sortedAndFilteredVehicleList));
  }

  double _calcWinPercent(int battles, int wins) => 100.0 / battles * wins;
}
