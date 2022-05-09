import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/common_widget/snackbar_widget.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';

import 'package:wot_statistic/common/theme/text_styles.dart';
import 'bloc/achieves_state.dart';

class AchievesWidget extends StatelessWidget {
  const AchievesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AchievesDataCubit cubit = context.read<AchievesDataCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Achieves, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(SignInPage.id);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<AchievesDataCubit, AchievesState>(
        listener: (context, currentState) {
          if (currentState is ErrorState) {
            createSnackBar(context, currentState.message);
          }
        },
        buildWhen: (prevState, currentState) =>
            (currentState is LoadingState || currentState is LoadedDataState),
        builder: (ctx, state) {
          if (state is LoadedDataState) {
            return SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                children: state.achievesData,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => cubit.refreshList(),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
