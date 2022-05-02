import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.heroTag,
    required this.bigImage,
    required this.description,
  }) : super(key: key);
  final String heroTag;
  final String bigImage;
  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Hero(
      tag: heroTag,
      child: Center(
        child: SizedBox(
          height: 3 * size.width / 4,
          width: 3 * size.width / 4,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    child: Image.network(
                      bigImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
