import 'package:flutter/foundation.dart';
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
      appBar: buildAppBar(context),
      body: BlocConsumer<AchievesDataCubit, AchievesState>(
        listener: (context, currentState) {
          if (currentState is ErrorState) {
            createSnackBar(context, currentState.message);
          }
        },
        buildWhen: (prevState, currentState) => prevState != currentState,
        builder: (ctx, state) {
          if (state is LoadedDataState) {
            return RefreshIndicator(
              onRefresh: () => cubit.refreshList(),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: (kIsWeb) ? 4 : 3,
                    children: state.achievesData,
                  ),
                ),
              ),
            );
          }
          if (state is ErrorState) {
            return refreshButton(cubit);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).Achieves, style: appBarTitle(context)),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignInPage.id);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Center refreshButton(AchievesDataCubit cubit) {
    return Center(
      child: IconButton(
        iconSize: 50,
        onPressed: () => cubit.refreshList(),
        icon: const Icon(
          Icons.refresh,
          size: 50,
        ),
      ),
    );
  }
}
