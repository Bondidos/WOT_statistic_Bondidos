import 'package:flutter/material.dart';

const portraitBackGround = "assets/background/main_background_portrait.jpg";
const landBackGround = "assets/background/main_background_land.jpg";

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  Color _newColor = Colors.red.shade200;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: TweenAnimationBuilder(
        tween: ColorTween(begin: Colors.white, end: _newColor),
        duration: const Duration(seconds: 3),
        onEnd: () {
          setState(
            () {
              _newColor = _newColor == Colors.red.shade200
                  ? Colors.white
                  : Colors.red.shade200;
            },
          );
        },
        builder: (_, Color? color, child) {
          return ColorFiltered(
            child: Image.asset(
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? portraitBackGround
                  : landBackGround,
              fit: BoxFit.cover,
              height: screenSize.height,
              width: screenSize.width,
            ),
            colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
          );
        },
      ),
    );
  }
}
