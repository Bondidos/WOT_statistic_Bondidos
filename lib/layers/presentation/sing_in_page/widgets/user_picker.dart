import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

class UserPicker extends StatelessWidget {
  const UserPicker({Key? key}) : super(key: key);

  List<DropdownMenuItem<String>> _createDropDownItem(
    BuildContext context,
    List<String> usersInCache,
  ) {
    final List<DropdownMenuItem<String>> result = [];
    for (int index = 0; index < usersInCache.length; index++) {
      result.add(_generateDropdownItem(usersInCache[index], context));
    }
    return result;
  }

  DropdownMenuItem<String> _generateDropdownItem(
      String value, BuildContext context) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        maxLines: 1,
        style: onPrimaryTitle(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color _onPrimary = Theme.of(context).colorScheme.onPrimary;
    final Color _primary = Theme.of(context).colorScheme.primary;
    final SignInCubit cubit = context.read<SignInCubit>();

    return BlocBuilder<SignInCubit, SignInState>(
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
                  color: _primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        dropdownColor: _primary,
                        value: userNameToDisplay,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: _onPrimary,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: _primary,
                        ),
                        onChanged: (userNickname) {
                          cubit.setCurrentUser(userNickname!);
                        },
                        items: _createDropDownItem(
                          context,
                          cubit.usersInCache,
                        ),
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
