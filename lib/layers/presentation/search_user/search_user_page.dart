import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/search_user/bloc/search_user_cubit.dart';

import '../../../common/theme/text_styles.dart';
import 'bloc/search_user_state.dart';

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
              child: BlocConsumer<SearchUserCubit, SearchUserState>(
                listener: (ctx, state) {
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
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        onChanged: (search) => context
                            .read<SearchUserCubit>()
                            .onTextChange(search),
                        decoration: const InputDecoration(
                            hintText: 'Enter player name'),
                      ),
                      Expanded(
                        child: state.foundList.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.foundList.length,
                                itemBuilder: (ctx, index) => ListTile(
                                  onTap: () => context
                                      .read<SearchUserCubit>()
                                      .viewUser(index),
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
    );
  }
}
