import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/bloc/personal_data_cubit.dart';

import '../../../common/theme/text_styles.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Account details";

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {

  int currentIndex = 0;
  final List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    context.read<PersonalDataCubit>().fetchPersonalData();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SignInPage.id);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Text(
          StatisticPage.id,
          style: appBarTitle(context),
        ),
      ),
      body:,
    );
  }
}
