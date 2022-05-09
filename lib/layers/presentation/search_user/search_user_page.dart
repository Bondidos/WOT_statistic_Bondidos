import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/search_user/bloc/search_user_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/statistic_page.dart';

import 'package:wot_statistic/common/theme/text_styles.dart';
import 'bloc/search_user_state.dart';
import 'package:wot_statistic/injection_container.dart' as di;

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key? key, required this.heroTag}) : super(key: key);
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Hero(
      tag: heroTag,
      child: Center(
        child: SizedBox(
          height: 3 * size.height / 4,
          width: 3 * size.width / 4,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocProvider<SearchUserCubit>(
                create: (context) => di.inj<SearchUserCubit>(),
                child: BlocConsumer<SearchUserCubit, SearchUserState>(
                  listener: (context, state) {
                    if (state is SearchError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: onSecondarySubtitle(context),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  builder: (ctx, state) {
                    SearchUserCubit cubit = ctx.read<SearchUserCubit>();
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextField(
                          cursorColor: Theme.of(context).colorScheme.onSurface,
                          onChanged: (search) => cubit.onTextChange(search),
                          decoration: InputDecoration(
                            filled: true,
                                fillColor: Theme.of(context).colorScheme.primary,
                              hintText: S.of(context).EnterPlayerName),
                        ),
                        Expanded(
                          child: state.foundList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: state.foundList.length,
                                  itemBuilder: (ctx, index) => ListTile(
                                    onTap: () async {
                                      await cubit.viewUser(index);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              StatisticPage.id);
                                    },
                                    title: Text(state.foundList[index].name),
                                  ),
                                )
                              : Container(),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
