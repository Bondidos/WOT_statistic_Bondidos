import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wot_statistic/common/screen_size.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.heroTag,
    required this.bigImage,
    required this.description,
    required this.color,
  }) : super(key: key);
  final String heroTag;
  final String bigImage;
  final String description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenSize screenSize = getSize(context);
    return Center(
      child: SizedBox(
        height: getActualSize(size, screenSize),
        width: getActualSize(size, screenSize),
        child: Hero(
          tag: heroTag,
          child: Material(
            elevation: 24,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: (color != null)
                ? color
                : Theme.of(context).colorScheme.onSurface,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.network(
                      bigImage,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: onCard(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getActualSize(Size size, ScreenSize screenSize) {
    if (kIsWeb) return size.width / 2;
    switch (screenSize) {
      case ScreenSize.phone:
        return 3 * size.width / 4;
      case ScreenSize.tablet:
        return size.width / 2;
      default:
        return size.width / 4;
    }
  }
}
