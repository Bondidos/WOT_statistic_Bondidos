import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';

import 'package:wot_statistic/common/constants/constants.dart';
import 'bloc/statistic_cubit.dart';
import 'package:wot_statistic/injection_container.dart' as di;

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Statistic page";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatisticCubit>(create: (context) => StatisticCubit()),
        BlocProvider<VehiclesDataCubit>(
            create: (context) => di.inj<VehiclesDataCubit>()),
        BlocProvider<AchievesDataCubit>(
            create: (context) => di.inj<AchievesDataCubit>()),
        BlocProvider<PersonalDataCubit>(
            create: (context) => di.inj<PersonalDataCubit>()),
      ],
      child: BlocBuilder<StatisticCubit, int>(
        builder: (context, index) {
          StatisticCubit cubit = context.read<StatisticCubit>();
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  label: S.of(context).Private,
                  icon: const Icon(Icons.privacy_tip),
                ),
                BottomNavigationBarItem(
                  label: S.of(context).Achieves,
                  icon: const Icon(Icons.check_circle),
                ),
                BottomNavigationBarItem(
                  label: S.of(context).Vehicles,
                  icon: const ImageIcon(ResizeImage(
                    AssetImage(TANK_ICON),
                    height: 36,
                    width: 36,
                  )),
                ),
              ],
              currentIndex: index,
              onTap: (pageIndex) => cubit.navigateTo(pageIndex),
            ),
            body: cubit.page(index),
          );
        },
      ),
    );
  }
}
