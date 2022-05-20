import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/presentation/common_widget/details_widget.dart';
import 'package:wot_statistic/layers/presentation/common_widget/hero_dialog_route.dart';
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
              color: null,
            ),
          ),
        );
      },
      child: Card(
        elevation: 24,
        color: Theme.of(context).colorScheme.onSurface,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  card.count.toString(),
                  style: onCard(context),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        card.imageBig,
                        loadingBuilder: (ctx,child,progress){
                          return progress == null
                              ? child
                              : const CircularProgressIndicator();
                        },
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      card.name,
                      style: onCard(context),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
