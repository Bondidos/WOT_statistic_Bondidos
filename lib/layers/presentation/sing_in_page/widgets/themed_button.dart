import 'package:flutter/material.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () => onTap(),
          child: Text(title)),
    );
  }
}