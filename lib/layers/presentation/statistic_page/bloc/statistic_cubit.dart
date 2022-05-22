import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/achieves.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/personal_data.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/vehicles.dart';

const startIndex = 0;

class StatisticCubit extends Cubit<int> {
  StatisticCubit() : super(startIndex);

  final List<Widget> _pages = [
    const PersonalDataWidget(),
    const AchievesWidget(),
    const VehiclesWidget(),
  ];

  Widget page(int index) => _pages[index];

  void navigateTo(int index) => emit(index);
}
