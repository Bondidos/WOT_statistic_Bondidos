import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/personal_data.dart';
import 'data.dart';
import 'Meta.dart';

class PersonalDataApi {
  @JsonKey(name: 'data')
  final Data? data;
  @JsonKey(name: 'meta')
  final Meta? meta;
  @JsonKey(name: 'status')
  String status;

  PersonalDataApi(
      {required this.data, required this.meta, required this.status});

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

  List<PersonalData> toList() {
    List<PersonalData> result = [];
    if (data == null || data?.userId == null) return result;
    result.add(PersonalData(
        dataTitle: 'clanId', dataValue: data!.userId.clanId.toString()));
    result.add(PersonalData(
        dataTitle: 'global_rating',
        dataValue: data!.userId.globalRating.toString()));

    if (data!.userId.private == null) return result;
    data!.userId.private!.privateData.forEach((key, value) {
      result.add(PersonalData(
          dataTitle: key, dataValue: value.toString()));
    });
    return result;
  }
}
