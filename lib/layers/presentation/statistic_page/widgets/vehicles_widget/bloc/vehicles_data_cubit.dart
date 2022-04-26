import 'package:bloc/bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';

import '../../../../../domain/entities/vehicles_data.dart';
import '../../../../../domain/use_cases/load_vehicles_data.dart';

class VehiclesDataCubit extends Cubit<VehiclesDataState> {
  final LoadVehiclesData loadVehicles;

  VehiclesDataCubit({required this.loadVehicles}) : super(const LoadingState()){
    fetchVehiclesData();
  }

  void fetchVehiclesData() async {
    try {
      final List<Vehicle> result = await loadVehicles.execute();
      emit(LoadedDataState(vehiclesData: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList(){
    fetchVehiclesData();
    return Future.delayed(const Duration(seconds: 2));
  }
}