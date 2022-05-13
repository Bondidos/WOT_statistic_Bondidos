import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_state.dart';

import 'package:wot_statistic/layers/domain/entities/achieves.dart';
import 'package:wot_statistic/layers/domain/use_cases/load_achieves_data.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/widgets/achieve_item_widget.dart';

const Map<int, String> achievesBySection = {
  0: 'Epic',
  1: 'Action',
  2: 'Special',
  3: 'Memorial',
  4: 'Group',
  5: 'Class',
};

class AchievesDataCubit extends Cubit<AchievesState> {
  final LoadAchievesData loadAchieves;

  AchievesDataCubit({required this.loadAchieves})
      : super(const LoadingState()) {
    fetchAchievesData();
  }

  Future<void> fetchAchievesData() async {
    try {
      if (state is! LoadingState) emit(const LoadingState());
      final List<List<Achieve>> sortedListsBySections =
          await loadAchieves.execute();
      List<StaggeredGridTile> listToDisplay =
          _createListToDisplay(sortedListsBySections);
      emit(LoadedDataState(achievesData: listToDisplay));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() => fetchAchievesData();

  List<StaggeredGridTile> _createListToDisplay(
      List<List<Achieve>> sortedListsBySections) {
    List<StaggeredGridTile> listToDisplay = [];

    for (int index = 0; index < achievesBySection.length; index++) {
      if (sortedListsBySections[index].isNotEmpty) {
        listToDisplay
            .add(_fromSectionName(sectionName: achievesBySection[index]!));
        listToDisplay.addAll(_fromAchieveList(sortedListsBySections[index]));
      }
    }
    return listToDisplay;
  }

  StaggeredGridTile _fromSectionName({required String sectionName}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: (kIsWeb) ? 4 : 3,
      mainAxisCellCount: 1,
      child: Center(
        child: Text(sectionName, textScaleFactor: 2),
      ),
    );
  }

  List<StaggeredGridTile> _fromAchieveList(List<Achieve> list) {
    List<StaggeredGridTile> result = [];
    for (var item in list) {
      var buffer = StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: Hero(
          tag: item.name,
          child: AchieveItemWidget(
            card: item,
          ),
        ),
      );
      result.add(buffer);
    }
    return result;
  }
}
