import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remoute/personal_api_data/private.dart';

class Data {
  @JsonKey(name: 'private')
  Private? private;
  @JsonKey(name: 'clan_id')
  int? clanId;
  @JsonKey(name: 'global_rating')
  int globalRating;

  Data(
      {required this.private,
      required this.clanId,
      required this.globalRating});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      private:
          json['private'] != null ? Private.fromJson(json['private']) : null,
      clanId: json['clan_id'],
      globalRating: json['global_rating'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clan_id'] = clanId;
    data['global_rating'] = globalRating;
    if (private != null) {
      data['private'] = private?.toJson();
    }
    return data;
  }
}
