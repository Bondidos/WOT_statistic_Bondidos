import 'package:flutter/material.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';

class ThemedButton extends StatelessWidget {
  const ThemedButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => onTap(),
      child: Text(
        title,
        style: onSurfaceSubtitle(context),
      ),
    );
  }
}
