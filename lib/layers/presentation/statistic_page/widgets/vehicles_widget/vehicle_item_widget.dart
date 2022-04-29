import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/domain/entities/vehicles_data.dart';

class VehicleItemWidget extends StatelessWidget {
  const VehicleItemWidget({
    Key? key,
    required this.vehicle,
  }) : super(key: key);
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: vehicle.isPremiumIgr ? Colors.amberAccent : Colors.blue,
      //todo color
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10),
      height: width / 3,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width / 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.network(
                      vehicle.image,
                      height: width / 3,
                      width: width / 3,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(nations[vehicle.nation]!),
                        Image.asset(
                          type[vehicle.type]!,
                          scale: 15,
                        ),
                        Text(tier[vehicle.tier]!)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: width / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                vehicle.markOfMastery != 0
                    ? Image.asset(markOfMastery[vehicle.markOfMastery]!)
                    : Container(),
                Text(vehicle.battles.toString()),
              ],
            ),
          ),
          SizedBox(
            width: width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  vehicle.name,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text((100.0 /
                            vehicle.battles *
                            vehicle.wins) //todo move to the func
                        .toStringAsFixed(2) +
                    '%')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const Map<String, String> nations = {
  "ussr": 'assets/nations/ussr.png',
  "usa": 'assets/nations/usa.png',
  "china": 'assets/nations/china.png',
  "uk": 'assets/nations/uk.png',
  "czech": 'assets/nations/czech.png',
  "sweden": 'assets/nations/sweden.png',
  "poland": 'assets/nations/poland.png',
  "italy": 'assets/nations/italy.png',
  "france": 'assets/nations/france.png',
  "japan": 'assets/nations/japan.png',
  "germany": 'assets/nations/germany.png',
};

const Map<String, String> type = {
  "mediumTank": 'assets/type/medium_tank.png',
  "heavyTank": 'assets/type/heavy_tank.png',
  "lightTank": 'assets/type/light_tank.png',
  "AT-SPG": 'assets/type/at_spg.png',
  "SPG": 'assets/type/spg.png',
};

const Map<int, String?> markOfMastery = {
  1: 'assets/mastery/rank_03.png',
  2: 'assets/mastery/rank_02.png',
  3: 'assets/mastery/rank_01.png',
  4: 'assets/mastery/rank_m.png',
};
const Map<int, String?> tier = {
  1: '  I ',
  2: ' II ',
  3: 'III ',
  4: ' IV ',
  5: '  V ',
  6: ' VI ',
  7: ' VII',
  8: 'VIII',
  9: ' IX ',
  10: '  X ',
};
