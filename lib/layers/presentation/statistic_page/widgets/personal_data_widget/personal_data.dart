import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';
import 'package:wot_statistic/layers/presentation/common_widget/common_widgets.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/private_item_widget/private_item_widget.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';

const globalRatingLogo = "assets/images/rating_img.png";

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
          buildWhen: (prevState, currentState) =>
              (currentState is LoadingState || currentState is LoadedDataState),
          builder: (ctx, state) {
            if (state is LoadedDataState) {
              var data = state.personalData;
              return RefreshIndicator(
                onRefresh: () => cubit.refreshList(),
                child: privateDataScrollView(data, context, state),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  CustomScrollView privateDataScrollView(
      PersonalData data, BuildContext context, LoadedDataState state) {
    List<PersonalDataCard> personalData = state.personalData.toCardList(context);
    return CustomScrollView(
      slivers: [
        _sliverAppBar(data, context, state),
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

  SliverAppBar _sliverAppBar(
      PersonalData data, BuildContext context, LoadedDataState state) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: _userNickName(data, context),
        background: _sliverAppBarBackGround(context, state),
      ),
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

  SizedBox _userNickName(PersonalData data, BuildContext context) => SizedBox(
      height: 20,
      child: Text(
        data.nickname,
        style: onSurfaceSubtitle(context),
        maxLines: 1,
      ));

  Container _sliverAppBarBackGround(
      BuildContext context, LoadedDataState state) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _clanLogo(state, context),
          _personalRating(state, context),
        ],
      ),
    );
  }

  Container _personalRating(LoadedDataState state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          Image.asset(
            globalRatingLogo,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          Text(
            state.personalData.globalRating.toString(),
            style: onCard(context),
          ),
        ],
      ),
    );
  }

  SizedBox _clanLogo(LoadedDataState state, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          state.personalData.clanLogo != null
              ? Image.network(
                  state.personalData.clanLogo!,
                  height: 120,
                  width: 120,
                  cacheWidth: 120,
                  cacheHeight: 120,
                  fit: BoxFit.cover,
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      S.of(context).NoClanMessage,
                      style: onCard(context),
                    ),
                  ),
                ),
          state.personalData.clan != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    state.personalData.clan!,
                    style: onCard(context),
                    maxLines: 2,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
