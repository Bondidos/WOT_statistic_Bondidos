import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/common_widget/common_widgets.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/vehicle_item_widget.dart';

import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';

class VehiclesWidget extends StatelessWidget {
  const VehiclesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VehiclesDataCubit cubit = context.read<VehiclesDataCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (ctx) => <PopupMenuEntry>[
              _sortMenuItem(onTap: cubit.sortByLvl, name: 'By Level'),
              _sortMenuItem(onTap: cubit.sortByBattles, name: 'By Battles'),
              _sortMenuItem(onTap: cubit.sortByMastery, name: 'By Mastery'),
              _sortMenuItem(onTap: cubit.sortByWins, name: 'By Wins'),
            ],
          ),
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (ctx) =>
                _createFilterItems(onTap: cubit.filterByNation),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(SignInPage.id);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<VehiclesDataCubit, VehiclesDataState>(
          listener: (context, currentState) {
            if (currentState is ErrorState) {
              createSnackBar(context, currentState.message);
            }
          },
          buildWhen: (prevState, currentState) =>
              (currentState is LoadingState || currentState is LoadedDataState),
          builder: (ctx, state) {
            if (state is LoadedDataState) {
              return ListView.builder(
                  itemCount: state.vehiclesData.length,
                  itemBuilder: (ctx, index) {
                    return VehicleItemWidget(
                        vehicle: state.vehiclesData[index]);
                  });
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

  PopupMenuItem _sortMenuItem({
    required Function onTap,
    required String name,
  }) {
    return PopupMenuItem(
      onTap: () => onTap(),
      child: Text(name),
    );
  }

  PopupMenuItem _filterMenuItem({
    required Function onTap,
    required String name,
    required String asset,
  }) {
    return PopupMenuItem(
      onTap: () => onTap(name),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(asset,width: 28,height: 18,),
          Text(name),
        ],
      ),
    );
  }

  List<PopupMenuEntry> _createFilterItems({required Function onTap}) {
    List<PopupMenuEntry> result = [];
    for (var nationKey in nations.keys) {
      result.add(_filterMenuItem(
          onTap: onTap, name: nationKey, asset: nations[nationKey]!));
    }
    return result;
  }
}

const Map<String, String> nations = {
  "All": 'assets/nations/all_nations.png',
  "Ussr": 'assets/nations/ussr.png',
  "Usa": 'assets/nations/usa.png',
  "China": 'assets/nations/china.png',
  "Uk": 'assets/nations/uk.png',
  "Czech": 'assets/nations/czech.png',
  "Sweden": 'assets/nations/sweden.png',
  "Poland": 'assets/nations/poland.png',
  "Italy": 'assets/nations/italy.png',
  "France": 'assets/nations/france.png',
  "Japan": 'assets/nations/japan.png',
  "Germany": 'assets/nations/germany.png',
};
