import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';

import '../../../../../common/constants/personal_data_images.dart';
import '../../../../../common/theme/text_styles.dart';
import '../../../sing_in_page/sign_in_page.dart';

class PersonalDataWidget extends StatelessWidget {
  const PersonalDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersonalDataCubit cubit = context.read<PersonalDataCubit>();

    return Scaffold(
      body: BlocConsumer<PersonalDataCubit, PersonalDataState>(
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
          //todo uncomment
          //todo extract to separate widget
          if (state is LoadedDataState) {
            var data = state.personalData;
            return RefreshIndicator(
              onRefresh: () => cubit.refreshList(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(data.nickname,
                          style: onSecondarySubtitle(context)),
                      background: Container(
                        padding: const EdgeInsets.only(top: 15),
                        color: Theme.of(context).colorScheme.primary,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                state.personalData.clanLogo != null
                                    ? Image.network(
                                        state.personalData.clanLogo!,
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.cover,
                                      )
                                    : const Text("Player have no clan"),
                                state.personalData.clan != null
                                    ? Text(state.personalData.clan!) //todo font
                                    : Container(),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  GLOBAL_RATING_LOGO,
                                  height: 140,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                    state.personalData.globalRating.toString()),
                                //todo font
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInPage.id);
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        List<PersonalDataCard> personalData =
                            state.personalData.private ?? [];
                        return PrivateItemWidget(
                          card: personalData[index],
                        );
                      },
                      childCount: state.personalData.private?.length ?? 0,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // mainAxisExtent: 150,
                    ),
                  ),
                ],
              ),
            );
          }
          //todo uncomment
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PrivateItemWidget extends StatelessWidget {
  const PrivateItemWidget({Key? key, required this.card}) : super(key: key);
  final PersonalDataCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(card.image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,),
          Text(card.title),
          Text(card.value),
        ],
      ),
    );
  }
}

//
// DecoratedBox(
// child: Container(
// height: 40,
// width: 40,
// ),
// decoration: BoxDecoration(
// color: Theme.of(context).colorScheme.onPrimary,
// borderRadius: BorderRadius.circular(15),
// ),
// );
