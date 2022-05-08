import 'package:flutter/material.dart';
import 'package:wot_statistic/common/widget/details_widget.dart';
import 'package:wot_statistic/common/widget/hero_dialog_route.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/domain/entities/achieves.dart';

class AchieveItemWidget extends StatelessWidget {
  const AchieveItemWidget({Key? key, required this.card}) : super(key: key);
  final Achieve card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (BuildContext context) => DetailsWidget(
              heroTag: card.name,
              description: card.description,
              bigImage: card.imageBig,
            ),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  card.count.toString(),
                  style: onCard(context).copyWith(fontSize: 8),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  card.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                Text(
                  card.name,
                  style: onCard(context).copyWith(fontSize: 8),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
