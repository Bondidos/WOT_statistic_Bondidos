import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/achieves.dart';
import '../widgets/personal_data_widget/personal_data.dart';
import '../widgets/vehicles.dart';

const startIndex = 0;

class StatisticCubit extends Cubit<int> {
  StatisticCubit() : super(startIndex);

  final List<Widget> _pages = [
    const PersonalDataWidget(),
    const AchievesWidget(),
    const VehiclesWidget(),
  ];

  Widget page(int index) => _pages[index];

  void navigateTo(int index){
    emit(index);
  }
}