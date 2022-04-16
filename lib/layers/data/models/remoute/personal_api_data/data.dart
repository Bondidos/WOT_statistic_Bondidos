import 'package:json_annotation/json_annotation.dart';
import 'package:wot_statistic/layers/data/models/remoute/personal_api_data/x560508396.dart';

class Data {
    @JsonKey(name: '560508396')
    final UserId userId;

    Data({required this.userId});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            userId: UserId.fromJson(json['560508396']),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
          data['560508396'] = userId.toJson();
        return data;
    }
}