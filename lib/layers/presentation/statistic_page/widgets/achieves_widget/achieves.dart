import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/common_widget/snackbar_widget.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/achieves_widget/bloc/achieves_data_cubit.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/comon_appbar/sliver_appBar.dart';
import 'bloc/achieves_state.dart';

class AchievesWidget extends StatelessWidget {
  const AchievesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AchievesDataCubit cubit = context.read<AchievesDataCubit>();

    return BlocConsumer<AchievesDataCubit, AchievesState>(
      listener: (context, currentState) {
        if (currentState is ErrorState) {
          createSnackBar(context, currentState.message);
        }
      },
      buildWhen: (prevState, currentState) => prevState != currentState,
      builder: (ctx, state) {
        if (state is LoadedDataState) {
          return Scaffold(
            appBar: (state.isPrivateDataAllow) ? buildAppBar(context) : null,
            body: RefreshIndicator(
              onRefresh: () => cubit.refreshList(),
              child: Scrollbar(
                child: state.isPrivateDataAllow
                    ? buildForSignedUser(state)
                    : buildForUserNoPrivate(context, state),
              ),
            ),
          );
        }
        if (state is ErrorState) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: refreshButton(cubit),
          );
        }
        return Scaffold(
          appBar: buildAppBar(context),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  SingleChildScrollView buildForSignedUser(LoadedDataState state) {
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: (kIsWeb) ? 4 : 3,
        children: state.achievesData,
      ),
    );
  }

  CustomScrollView buildForUserNoPrivate(
      BuildContext context, LoadedDataState state) {
    return CustomScrollView(
      slivers: [
        UserInfoAppBar(
          nickname: state.userNoPrivateInfo?.nickname ?? '',
          globalRating: state.userNoPrivateInfo?.globalRating.toString() ?? '',
          clanName: state.userNoPrivateInfo?.clan,
          clanLogo: state.userNoPrivateInfo?.clanLogo,
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: StaggeredGrid.count(
              crossAxisCount: (kIsWeb) ? 4 : 3,
              children: state.achievesData,
            ),
          ),
        ),
      ],
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
