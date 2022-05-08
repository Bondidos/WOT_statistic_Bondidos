import 'package:flutter/material.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';

class PrivateItemWidget extends StatelessWidget {
  const PrivateItemWidget({Key? key, required this.card}) : super(key: key);
  final PersonalDataCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            card.image,
            height: 80,
            width: 80,
            cacheHeight: 120,
            cacheWidth: 120,
            fit: BoxFit.cover,
          ),
          Text(
            card.title,
            style: onCard(context),
            textAlign: TextAlign.center,
          ),
          Text(
            card.value,
            style: onCard(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
