import 'package:flutter/material.dart';
import 'package:wot_statistic/common/text_styles.dart';
import 'package:wot_statistic/layers/domain/entities/personal_data_card.dart';

class PrivateItemWidget extends StatelessWidget {
  const PrivateItemWidget({Key? key, required this.card}) : super(key: key);
  final PersonalDataCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 24,
      color: Theme.of(context).colorScheme.onSurface,
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Image.asset(
              card.image,
              width: double.infinity,
              cacheHeight: 120,
              cacheWidth: 120,
              fit: BoxFit.fitHeight,
            ),
          ),
          Flexible(
            child: Text(
              card.title,
              style: onCard(context).copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Text(
              card.value,
              style: onCard(context).copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
