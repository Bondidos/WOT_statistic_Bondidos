import 'package:flutter/material.dart';

enum ScreenSize { phone, tablet, desktop }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.desktop;
  if (deviceWidth > 600) return ScreenSize.tablet;
  return ScreenSize.phone;
}
