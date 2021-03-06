import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';
import 'package:wot_statistic/layers/presentation/common_widget/snackbar_widget.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/comon_appbar/sliver_app_bar.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/private_item_widget/private_item_widget.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';

class PersonalDataWidget extends StatelessWidget {
  const PersonalDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersonalDataCubit cubit = context.read<PersonalDataCubit>();

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<PersonalDataCubit, PersonalDataState>(
          listener: (context, currentState) {
            if (currentState is ErrorState) {
              createSnackBar(context, currentState.message);
            }
          },
          buildWhen: (prevState, currentState) => prevState != currentState,
          builder: (ctx, state) {
            if (state is LoadedDataState) {
              var data = state.personalData;
              return RefreshIndicator(
                onRefresh: () => cubit.refreshList(),
                child: privateDataScrollView(data, context, state),
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
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).Private),
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

  Center refreshButton(PersonalDataCubit cubit) {
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

  CustomScrollView privateDataScrollView(
      PersonalData data, BuildContext context, LoadedDataState state) {
    List<PersonalDataCard> personalData =
        state.personalData.toCardList(context);
    return CustomScrollView(
      slivers: [
        UserInfoAppBar(
          nickname: state.personalData.nickname,
          globalRating: state.personalData.globalRating.toString(),
          clanName: state.personalData.clan,
          clanLogo: state.personalData.clanLogo,
        ),
        (state.personalData.private != null)
            ? SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PrivateItemWidget(
                      card: personalData[index],
                    );
                  },
                  childCount: personalData.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              )
            : SliverFillRemaining(
                child: Center(
                  child: Text(S.of(context).InviteToSignIn),
                ),
              )
      ],
    );
  }
}
