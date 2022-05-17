import 'package:flutter/material.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/sign_in_page.dart';

const globalRatingLogo = "assets/images/rating_img.png";

class UserInfoAppBar extends StatelessWidget {
  const UserInfoAppBar({
    Key? key,
    required this.nickname,
    required this.clanLogo,
    required this.clanName,
    required this.globalRating,
  }) : super(key: key);
  final String nickname;
  final String? clanLogo;
  final String? clanName;
  final String globalRating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: _userNickName(nickname, context),
        background: _sliverAppBarBackGround(
          context,
          clanLogo,
          clanName,
          globalRating,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignInPage.id);
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}

SizedBox _userNickName(String nickName, BuildContext context) => SizedBox(
    height: 25,
    child: Text(
      nickName,
      style: onSurfaceSubtitle(context),
      maxLines: 1,
    ));

Container _sliverAppBarBackGround(
  BuildContext context,
  String? clanLogo,
  String? clanName,
  String globalRating,
) {
  return Container(
    padding: const EdgeInsets.only(top: 15),
    color: Theme.of(context).colorScheme.primary,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _clanLogo(clanLogo, clanName, context),
        _personalRating(globalRating, context),
      ],
    ),
  );
}

Container _personalRating(String globalRating, BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20),
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      children: [
        Image.asset(
          globalRatingLogo,
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
        Text(
          globalRating,
          style: onCard(context),
        ),
      ],
    ),
  );
}

SizedBox _clanLogo(String? clanLogo, String? clanName, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      children: [
        clanLogo != null
            ? Image.network(
                clanLogo,
                height: 120,
                width: 120,
                cacheWidth: 120,
                cacheHeight: 120,
                fit: BoxFit.cover,
              )
            : Expanded(
                child: Center(
                  child: Text(
                    S.of(context).NoClanMessage,
                    style: onCard(context),
                  ),
                ),
              ),
        clanName != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  clanName,
                  style: onCard(context),
                  maxLines: 2,
                ),
              )
            : Container(),
      ],
    ),
  );
}
