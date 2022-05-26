import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/search_user/bloc/search_user_cubit.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/statistic_page.dart';
import 'package:wot_statistic/common/text_styles.dart';
import 'bloc/search_user_state.dart';
import 'package:wot_statistic/injection_container.dart' as di;

const searchUserPageRatio = 3 / 4;

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key? key, required this.heroTag}) : super(key: key);
  final String heroTag;
  final bool isShowPrivateData = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * searchUserPageRatio,
        width: size.width * searchUserPageRatio,
        child: Hero(
          tag: heroTag,
          child: Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
                          Flexible(
                            child: TextField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.white24,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    const TextStyle(color: Colors.white30),
                                hintText: S.of(context).EnterPlayerName,
                              ),
                              onChanged: (search) => cubit.onTextChange(search),
                            ),
                          ),
                          Expanded(
                            child: state.foundList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.foundList.length,
                                    itemBuilder: (ctx, index) => ListTile(
                                      onTap: () async {
                                        await cubit.viewUser(index);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          StatisticPage.id,
                                          ModalRoute.withName(StatisticPage.id),
                                          arguments: isShowPrivateData,
                                        );
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
      ),
    );
  }
}
