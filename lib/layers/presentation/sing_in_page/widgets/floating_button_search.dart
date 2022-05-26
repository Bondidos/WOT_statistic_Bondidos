import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/presentation/search_user/search_user_page.dart';
import 'package:wot_statistic/layers/presentation/common_widget/hero_dialog_route.dart';

class FloatingButtonSearch extends StatelessWidget {
  const FloatingButtonSearch({
    Key? key,
    required this.heroTag,
  }) : super(key: key);

  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              HeroDialogRoute(
                builder: (BuildContext context) => SearchUserPage(
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              elevation: 24,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
