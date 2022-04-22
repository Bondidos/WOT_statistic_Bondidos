import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';

import '../../../../../domain/use_cases/load_personal_data.dart';
part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  final LoadPersonalData loadData;

  PersonalDataCubit({required this.loadData}) : super(const LoadingState()){
    fetchPersonalData();
  }

  void fetchPersonalData() async {
    try {
      final PersonalData result = await loadData.execute();
      emit(LoadedDataState(personalData: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList(){
    fetchPersonalData();
    return Future.delayed(const Duration(seconds: 2));
  }

  void extendToken(){
    //todo extend token
  }
}
