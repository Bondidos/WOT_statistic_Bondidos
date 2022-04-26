import 'package:bloc/bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_state.dart';

import '../../../../../data/models/remote/achievements_data/achievement_data.dart';
import '../../../../../domain/entities/achieves.dart';
import '../../../../../domain/use_cases/load_achieves_data.dart';

class AchievesDataCubit extends Cubit<AchievesState> {
  final LoadAchievesData loadAchieves;

  AchievesDataCubit({required this.loadAchieves}) : super(const LoadingState()){
    fetchAchievesData();
  }

  void fetchAchievesData() async {
    try {
      final List<AchievementData> result = await loadAchieves.execute();
      emit(LoadedDataState(achievesData: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList(){
    fetchAchievesData();
    return Future.delayed(const Duration(seconds: 2));
  }
}