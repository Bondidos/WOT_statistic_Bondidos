import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  Color _newColor = Colors.red.shade200;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: ColorTween(begin: Colors.white, end: _newColor),
        duration: const Duration(seconds: 3),
        onEnd: () {
          setState(() {
            _newColor = _newColor == Colors.red.shade200
                ? Colors.white
                : Colors.red.shade200;
          });
        },
        builder: (_, Color? color, child) {
          return ColorFiltered(
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Image.asset(
                    "assets/background/main_background_portrait.jpg",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  )
                : Image.asset(
                    "assets/background/main_background_land.jpg",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
            colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
          );
        },
      ),
    );
  }
}
