import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import '../../../domain/entities/user.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // todo stream builder looks like better idea ?

    return BlocBuilder<SingInCubit, SingInState>(
      buildWhen: (prevState, currentState) =>
          (currentState.status == SingInStatus.usersSynced ||
              currentState.status == SingInStatus.initialized &&
                  currentState != prevState),
      builder: (ctx, state) {
        if (state.status == SingInStatus.usersSynced ||
            state.status == SingInStatus.initialized) {
          final List<User> previousUsers = state.prevUsers;

          List<String> usersInCache =
              previousUsers.map((e) => e.nickname).toList();

          String? currentUser = (usersInCache.isEmpty) ? null : usersInCache[0];

          return currentUser != null
              ? Column(
                  children: [
                    const Text("Login as..."),
                    DropdownButton<String>(
                      value: currentUser,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: Theme.of(context).textTheme.bodyMedium,
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onChanged: (data) {
                        if (data != null) {
                          currentUser = data;
                        }
                      },
                      items:
                          usersInCache.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )
              : Container();
        }
        return Container();
      },
    );
  }
}
