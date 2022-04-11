import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/theme/text_styles.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key? key}) : super(key: key);
  static const String id = "Account details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id,style: appBarTitle(context),),
      ),
      body: const Center(
        child: Text("NotImplemented"),
      ),
    );
  }
}
