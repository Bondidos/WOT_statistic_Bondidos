import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';

import '../../../../../common/theme/text_styles.dart';

class VehiclesWidget extends StatelessWidget {
  const VehiclesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VehiclesDataCubit cubit = context.read<VehiclesDataCubit>();

    return Scaffold(
      body: BlocConsumer<VehiclesDataCubit, VehiclesDataState>(
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
              var data = state.vehiclesData;
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
