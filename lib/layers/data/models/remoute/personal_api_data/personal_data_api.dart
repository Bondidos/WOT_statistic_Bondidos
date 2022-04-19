import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/personal_data.dart';
import 'data.dart';
import 'Meta.dart';

class PersonalDataApi {
  @JsonKey(name: 'data')
  final Map<String,Data>? data;
  @JsonKey(name: 'meta')
  final Meta? meta;
  @JsonKey(name: 'status')
  String status;

  PersonalDataApi(
      {required this.data, required this.meta, required this.status});

  factory PersonalDataApi.fromJson(Map<String, dynamic> json) {
    return PersonalDataApi(
      data: json['data'] != null ? <String,Data>{
        json['data'].keys.first : Data.fromJson(json['data'][json['data'].keys.first]),
      } : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!;
    if (meta != null) {
      data['meta'] = meta?.toJson();
    }
    return data;
  }

  List<PersonalData> toList() {
    List<PersonalData> result = [];
    if (data?[data?.keys.first] == null) return result;
    result.add(PersonalData(
        dataTitle: 'clanId', dataValue: data![data?.keys.first]!.clanId.toString()));
    result.add(PersonalData(
        dataTitle: 'global_rating',
        dataValue: data![data?.keys.first]!.globalRating.toString()));

    if (data![data?.keys.first]!.private == null) return result;
    data![data?.keys.first]!.private!.privateData.forEach((key, value) {
      result.add(PersonalData(
          dataTitle: key, dataValue: value.toString()));
    });
    return result;
  }
}
