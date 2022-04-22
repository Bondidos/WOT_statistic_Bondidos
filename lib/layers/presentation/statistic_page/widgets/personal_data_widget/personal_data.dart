import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/widgets/personal_data_widget/bloc/personal_data_cubit.dart';

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
                    // title: Text('personal data', style: appBarTitle(context)),
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(data.nickname, style: appBarTitle(context)),
                      background: Container(
                        color: Theme.of(context).colorScheme.primary,
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
                    //SliverChildBuilderDelegate
                    // delegate: SliverChildBuilderDelegate(
                    /*(context, index) {
                      return const PrivateItemWidget();
                    },
                    childCount: 20, //state.dataList.length,*/
                    /*  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      mainAxisExtent: 150,
                    ),*/
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const PrivateItemWidget();
                      },
                      childCount: 20,
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
  const PrivateItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      margin: const EdgeInsets.all(15),
      /* shape: Border.all(
        color: const Color(0xfffca311),
        width: 3.0,
        style: BorderStyle.none,
      ),*/
      child: Text("item"),
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