import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/bloc/personal_data_cubit.dart';

import '../../../common/theme/text_styles.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Account details";

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
          id,
          style: appBarTitle(context),
        ),
      ),
      body: BlocConsumer<PersonalDataCubit, PersonalDataStatus>(
        listener: (ctx, state) {
          if (state is ErrorStatus) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (ctx, status) {
          if (status is LoadedDataStatus) {
            return ListView.builder(
              itemCount: status.dataList.length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text(status.dataList[index].dataTitle),
                subtitle: Text(status.dataList[index].dataValue),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
