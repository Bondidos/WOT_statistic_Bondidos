import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/common/screen_size.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/common_widget/snackbar_widget.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/bloc/vehicles_state.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/vehicles_widget/vehicle_item_widget.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';

class VehiclesWidget extends StatelessWidget {
  const VehiclesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VehiclesDataCubit cubit = context.read<VehiclesDataCubit>();
    ScreenSize screenSize = getSize(context);

    return BlocConsumer<VehiclesDataCubit, VehiclesDataState>(
      listener: (context, currentState) {
        if (currentState is ErrorState) {
          cubit.clearBufferList();
          createSnackBar(context, currentState.message);
        }
      },
      buildWhen: (prevState, currentState) => (prevState != currentState),
      builder: (ctx, state) {
        if (state is LoadedDataState) {
          return Scaffold(
            appBar: buildAppBar(context, cubit),
            body: RefreshIndicator(
              onRefresh: () => cubit.refreshList(),
              child: Scrollbar(
                child: (screenSize == ScreenSize.phone)
                    ? buildListView(state, screenSize)
                    : buildGridView(state, screenSize),
              ),
            ),
          );
        }
        if (state is ErrorState) {
          return Scaffold(
            appBar: buildAppBar(context, cubit),
            body: refreshButton(cubit),
          );
        }
        return Scaffold(
          appBar: buildAppBar(context, cubit),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  GridView buildGridView(LoadedDataState state, ScreenSize screenSize) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return VehicleItemWidget(
          vehicle: state.vehiclesData[index],
          screenSize: screenSize,
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (kIsWeb) ? 3 : 2,
      ),
    );
  }

  ListView buildListView(LoadedDataState state, ScreenSize screenSize) {
    return ListView.builder(
      itemCount: state.vehiclesData.length,
      itemBuilder: (ctx, index) {
        return VehicleItemWidget(
          vehicle: state.vehiclesData[index],
          screenSize: screenSize,
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, VehiclesDataCubit cubit) {
    return AppBar(
      title: Text(S.of(context).Vehicles),
      actions: [
        PopupMenuButton(
          icon: (cubit.nationFilter == nationByDefault)
              ? const Icon(Icons.filter_alt)
              : Image.asset(nations[cubit.nationFilter]!),
          itemBuilder: (ctx) => _createFilterItems(onTap: cubit.filterByNation),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.sort),
          itemBuilder: (ctx) => <PopupMenuEntry>[
            _sortMenuItem(
                cubit: cubit, name: S.of(context).ByLevel, order: byLvl),
            _sortMenuItem(
                cubit: cubit, name: S.of(context).ByBattles, order: byBattles),
            _sortMenuItem(
                cubit: cubit, name: S.of(context).ByMastery, order: byMastery),
            _sortMenuItem(
                cubit: cubit, name: S.of(context).ByWins, order: byWins),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignInPage.id);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Center refreshButton(VehiclesDataCubit cubit) {
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

  PopupMenuItem _sortMenuItem({
    required VehiclesDataCubit cubit,
    required String name,
    required int order,
  }) {
    int currentSortOrder = cubit.sortOrderCheck;
    return PopupMenuItem(
      onTap: () => cubit.sortBy(order),
      child: Row(
        children: [
          (currentSortOrder == order)
              ? const Icon(Icons.radio_button_on)
              : const Icon(Icons.radio_button_off),
          Text(name),
        ],
      ),
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
          Image.asset(
            asset,
            width: 28,
            height: 18,
          ),
          Expanded(
            child: Text(
              _translate(name),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _translate(String name) {
    switch (name) {
      case "All":
        return S.current.All;
      case "Ussr":
        return S.current.Ussr;
      case "Usa":
        return S.current.Usa;
      case "China":
        return S.current.China;
      case "Uk":
        return S.current.Uk;
      case "Czech":
        return S.current.Czech;
      case "Sweden":
        return S.current.Sweden;
      case "Poland":
        return S.current.Poland;
      case "Italy":
        return S.current.Italy;
      case "France":
        return S.current.France;
      case "Japan":
        return S.current.Japan;
      case "Germany":
        return S.current.Germany;
      default:
        return "";
    }
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
