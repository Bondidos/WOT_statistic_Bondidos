import 'package:json_annotation/json_annotation.dart';

import 'data.dart';
import 'Meta.dart';

class PersonalDataApi {
    @JsonKey(name: 'data')
    final Data? data;
    @JsonKey(name: 'meta')
    final Meta? meta;
    @JsonKey(name: 'status')
    String status;

    PersonalDataApi({required this.data, required this.meta, required this.status});

    factory PersonalDataApi.fromJson(Map<String, dynamic> json) {
        return PersonalDataApi(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['status'] = status;
          data['data'] = this.data?.toJson();
        if (meta != null) {
            data['meta'] = meta?.toJson();
        }
        return data;
    }
}