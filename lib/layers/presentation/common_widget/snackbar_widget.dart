import 'package:flutter/material.dart';

import 'package:wot_statistic/common/theme/text_styles.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> createSnackBar(BuildContext context,String message){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: onSecondarySubtitle(context),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}