import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/search_user/bloc/search_user_cubit.dart';

import 'bloc/search_user_state.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key? key, required this.heroTag}) : super(key: key);
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Hero(
      tag: heroTag,
      child: Center(
        child: SizedBox(
          height: 3 * size.height / 4,
          width: 3 * size.width / 4,
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<SearchUserCubit, SearchUserState>(
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
                                  title: Text(state.foundList[index].name),
                                ),
                              )
                            : Container(),
                      )
                      /*state.foundList.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.foundList.length,
                              itemBuilder: (ctx, index) => ListTile(
                                title: Text(state.foundList[index].name),
                              ),
                            )
                          : Container(),*/
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
