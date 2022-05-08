import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

const notPicked = "Not Picked";

class UserPicker extends StatelessWidget {
  const UserPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color _onSecondary = Theme.of(context).colorScheme.onSecondary;
    final SingInCubit cubit = context.read<SingInCubit>();

    return BlocBuilder<SingInCubit, SignInState>(
      buildWhen: (prevState, currentState) =>
          (currentState is SignInStateLoaded),
      builder: (ctx, state) {
        final String currentUser = (cubit.currentUser == null)
            ? notPicked
            : cubit.currentUser!.nickname;

        final String userNameToDisplay =
            (currentUser == notPicked && cubit.usersInCache.isNotEmpty)
                ? cubit.usersInCache.first
                : currentUser;

        return userNameToDisplay != notPicked
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _onSecondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        dropdownColor: _onSecondary,
                        value: userNameToDisplay,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: _onPrimary,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: _onSecondary,
                        ),
                        onChanged: (userNickname) {
                          cubit.setCurrentUser(userNickname!);
                        },
                        items: cubit.createDropDownItem(context),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
