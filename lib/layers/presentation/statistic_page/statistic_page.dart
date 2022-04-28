import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/constants.dart';
import 'bloc/statistic_cubit.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Statistic page";

  static const List<String> title = ["Personal data", "Achieves", "Vehicles"];

  @override
  Widget build(BuildContext context) {
    StatisticCubit cubit = context.read<StatisticCubit>();
    return BlocBuilder<StatisticCubit, int>(
      builder: (context, index) {
        return Scaffold(
          /*appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(SignInPage.id);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
            title: Text(
              title[index],
              style: appBarTitle(context),
            ),
          ),*/
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: "Private",
                icon: Icon(Icons.privacy_tip),
              ),
              BottomNavigationBarItem(
                label: "Achieves",
                icon: Icon(Icons.check_circle),
              ),
              BottomNavigationBarItem(
                label: "Vehicles",
                icon: ImageIcon(AssetImage(TANK_ICON)),
              ),
            ],
            currentIndex: index,
            onTap: (pageIndex) => cubit.navigateTo(pageIndex),
          ),
          body: cubit.page(index),
        );
      },
    );
  }
}
