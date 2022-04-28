import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_state.dart';

import '../../../../../domain/entities/achieves.dart';
import '../../../../../domain/use_cases/load_achieves_data.dart';
import '../achieves.dart';

class AchievesDataCubit extends Cubit<AchievesState> {
  final LoadAchievesData loadAchieves;

  AchievesDataCubit({required this.loadAchieves})
      : super(const LoadingState()) {
    fetchAchievesData();
  }

  void fetchAchievesData() async {
    try {
      final List<List<Achieve>> sortedListsBySections =
          await loadAchieves.execute();
      List<StaggeredGridTile> listToDisplay =
          _createListToDisplay(sortedListsBySections);
      emit(LoadedDataState(achievesData: listToDisplay));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> refreshList() {
    fetchAchievesData();
    return Future.delayed(const Duration(seconds: 2));
  }
  // todo logic if emptyList
  List<StaggeredGridTile> _createListToDisplay(
      List<List<Achieve>> sortedListsBySections) {
    List<StaggeredGridTile> listToDisplay = [];
    listToDisplay.add(fromSectionName("Epic"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[0]));
    listToDisplay.add(fromSectionName("Action"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[1]));
    listToDisplay.add(fromSectionName("Special"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[2]));
    listToDisplay.add(fromSectionName("Memorial"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[3]));
    listToDisplay.add(fromSectionName("Group"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[4]));
    listToDisplay.add(fromSectionName("Class"));
    listToDisplay.addAll(_fromAchieveList(sortedListsBySections[5]));
    return listToDisplay;
  }

  StaggeredGridTile fromSectionName(String name) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 3,
      mainAxisCellCount: 1,
      child: Text(name),
    );
  }

  List<StaggeredGridTile> _fromAchieveList(List<Achieve> list) {
    List<StaggeredGridTile> result = [];
    for (var item in list) {
      var buffer = StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        child: AchieveItemWidget(
          card: item,
        ),
      );
      result.add(buffer);
    }
    return result;
  }
}
