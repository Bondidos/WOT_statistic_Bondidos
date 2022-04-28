import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';

import '../../../../../common/theme/text_styles.dart';
import '../../../../domain/entities/achieves.dart';
import 'bloc/achieves_state.dart';

class AchievesWidget extends StatelessWidget {
  const AchievesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AchievesDataCubit cubit = context.read<AchievesDataCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Achieves', style: appBarTitle(context)),
      ),
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
            return GridView.builder(
              itemCount: state.achievesData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (ctx, index) {
                return AchieveItemWidget(card: state.achievesData[index]);
              },
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

class AchieveItemWidget extends StatelessWidget {
  const AchieveItemWidget({Key? key, required this.card}) : super(key: key);
  final Achieve card;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      // margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              card.count.toString(),
              style: onCard(context),
            ),
          ),
          Image.network(
            card.imageBig ?? card.image ?? '', //todo images
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          Text(
            card.name,
            style: onCard(context).copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
