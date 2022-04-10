import 'package:flutter/material.dart';

TextStyle onPrimarySubtitle(BuildContext context) {
  return TextStyle(
    fontSize: Theme.of(context).textTheme.headline6?.fontSize,
    fontStyle: FontStyle.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle onSurfaceSubtitle(BuildContext context) {
  return TextStyle(
    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
    fontStyle: FontStyle.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle onSecondarySubtitle(BuildContext context) {
  return TextStyle(
    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
    fontStyle: FontStyle.normal,
    color: Theme.of(context).colorScheme.onSecondary,
  );
}

TextStyle appBarTitle(BuildContext context) {
  return TextStyle(
    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
    fontStyle: FontStyle.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle onPrimaryTitle(BuildContext context) {
  return TextStyle(
    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
    fontStyle: FontStyle.normal,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}
