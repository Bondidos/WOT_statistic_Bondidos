import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';

import '../../../../../common/theme/text_styles.dart';
import '../../../../data/models/remote/achievements_data/achievement_data.dart';
import '../../../../domain/entities/achieves.dart';
import 'bloc/achieves_state.dart';

class AchievesWidget extends StatelessWidget {
  const AchievesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AchievesDataCubit cubit = context.read<AchievesDataCubit>();

    return Scaffold(
      body: BlocConsumer<AchievesDataCubit, AchievesState>(
          listener: (context, currentState) {
            if (currentState is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    currentState.message,
                    style: onSecondarySubtitle(context),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          buildWhen: (prevState, currentState) =>
              (currentState is LoadingState || currentState is LoadedDataState),
          builder: (ctx, state) {
            if (state is LoadedDataState) {
              final List<Achieve> data = state.achievesData;
              return const Center(
                child: Text("state loaded"),
              );
            }
            return RefreshIndicator(
              onRefresh: () => cubit.refreshList(),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
