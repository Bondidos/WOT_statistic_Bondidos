import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_personal_data_use_case.dart';

part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  final LoadPersonalDataUseCase loadData;

  PersonalDataCubit({required this.loadData}) : super(const LoadingState()) {
    _fetchPersonalData();
  }

  void _fetchPersonalData() async {
    try {
      if (state is! LoadingState) emit(const LoadingState());
      final PersonalData result = await loadData.execute();
      emit(LoadedDataState(personalData: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() async {
    _fetchPersonalData();
  }
}
