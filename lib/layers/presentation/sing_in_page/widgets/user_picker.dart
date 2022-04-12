import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import '../../../../common/constants/constants.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color _secondary = Theme.of(context).colorScheme.secondary;

    return BlocBuilder<SingInCubit, SingInState>(
      buildWhen: (prevState, currentState) =>
          (currentState.status == SingInStatus.usersSynced),
      builder: (ctx, state) {
        if (state.status == SingInStatus.usersSynced ||
            state.status == SingInStatus.initialized) {

          final List<String> usersInCache =
              state.prevUsers.map((e) => "${e.nickname} ${state.prevUsers.indexOf(e)}").toList();
          final String currentUser = context.read<SingInCubit>().currentUserName;

          String userNameToDisplay =
              (usersInCache.isNotEmpty && currentUser == NOT_PICKED)
                  ? usersInCache.first
                  : currentUser;

          return userNameToDisplay != NOT_PICKED
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          dropdownColor: _secondary,
                          value: userNameToDisplay,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: _onPrimary,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: _secondary,
                          ),
                          onChanged: (data) {
                            if (data != null) {
                              //context.read<SingInCubit>().setCurrentUser(data);
                            }
                          },
                          items: usersInCache
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                maxLines: 1,
                                style: onPrimaryTitle(context),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                )
              : Container();
        }
        return Container();
      },
    );
  }
}
