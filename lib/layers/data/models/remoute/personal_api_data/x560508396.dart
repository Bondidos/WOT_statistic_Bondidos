
import 'package:json_annotation/json_annotation.dart';

import 'private.dart';

class UserId {
    @JsonKey(name: 'private')
    Private? private;
    @JsonKey(name: 'clan_id')
    int clanId;
    @JsonKey(name: 'global_rating')
    int globalRating;

    UserId({required this.private, required this.clanId, required this.globalRating});

    factory UserId.fromJson(Map<String, dynamic> json) {
        return UserId(
            private: json['private'] != null ? Private.fromJson(json['private']) : null,
            clanId: json['clan_id'],
            globalRating: json['global_rating'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['clan_id'] = clanId;
        data['global_rating'] = globalRating;
        if (private != null) {
            data['`private`'] = private?.toJson();
        }
        return data;
    }
}