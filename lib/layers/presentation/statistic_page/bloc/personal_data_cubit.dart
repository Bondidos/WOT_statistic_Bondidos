import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';

import '../../../domain/use_cases/load_personal_data.dart';

part 'personal_data_status.dart';

class PersonalDataCubit extends Cubit<PersonalDataStatus> {
  final LoadPersonalData loadData;

  PersonalDataCubit({required this.loadData}) : super(const LoadingStatus()) {
    fetchPersonalData();
  }

  void fetchPersonalData() async {
    try {
      final List<PersonalData> result = await loadData.execute();
      emit(LoadedDataStatus(dataList: result));
    } catch (e) {
      emit(ErrorStatus(message: e.toString()));
    }
  }

  void extendToken(){
    //todo extend token
  }
}
