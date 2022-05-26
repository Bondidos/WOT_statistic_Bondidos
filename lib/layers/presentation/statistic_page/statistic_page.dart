import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'bloc/statistic_cubit.dart';
import 'package:wot_statistic/injection_container.dart' as di;

const tankIcon = "assets/icons/tank_icon.png";

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Statistic page";

  @override
  Widget build(BuildContext context) {
    bool isPrivateDataAllow =
        (ModalRoute.of(context)?.settings.arguments != null)
            ? ModalRoute.of(context)?.settings.arguments as bool
            : true;
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatisticCubit>(create: (context) => StatisticCubit()),
        BlocProvider<VehiclesDataCubit>(
            create: (context) => di.inj<VehiclesDataCubit>()),
        BlocProvider<AchievesDataCubit>(
            create: (context) =>
                di.inj<AchievesDataCubit>()..init(isPrivateDataAllow)),
        BlocProvider<PersonalDataCubit>(
            create: (context) => di.inj<PersonalDataCubit>()),
      ],
      child: BlocBuilder<StatisticCubit, int>(
        builder: (context, index) {
          StatisticCubit cubit = context.read<StatisticCubit>();
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Theme.of(context).colorScheme.onSecondary,
              items:
                  _buildPagesAccordingWithPrivate(isPrivateDataAllow),
              currentIndex: index,
              onTap: (pageIndex) => cubit.navigateTo(pageIndex),
            ),
            body: cubit.page(
              _navigateAccordingWithPrivateDataAllow(isPrivateDataAllow, index),
            ),
          );
        },
      ),
    );
  }

  int _navigateAccordingWithPrivateDataAllow(
    bool isPrivateDataAllow,
    int index,
  ) =>
      isPrivateDataAllow ? index : ++index;

  List<BottomNavigationBarItem> _buildPagesAccordingWithPrivate(
    bool privateData,
  ) {
    return privateData
        ? [
            BottomNavigationBarItem(
              label: S.current.Private,
              icon: const Icon(Icons.privacy_tip),
            ),
            BottomNavigationBarItem(
              label: S.current.Achieves,
              icon: const Icon(Icons.check_circle),
            ),
            BottomNavigationBarItem(
              label: S.current.Vehicles,
              icon: const ImageIcon(
                ResizeImage(
                  AssetImage(tankIcon),
                  height: 36,
                  width: 36,
                ),
              ),
            ),
          ]
        : [
            BottomNavigationBarItem(
              label: S.current.Achieves,
              icon: const Icon(Icons.check_circle),
            ),
            BottomNavigationBarItem(
              label: S.current.Vehicles,
              icon: const ImageIcon(
                ResizeImage(
                  AssetImage(tankIcon),
                  height: 36,
                  width: 36,
                ),
              ),
            ),
          ];
  }
}
