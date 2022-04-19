import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/personal_data.dart';
import 'data.dart';
import 'meta.dart';

class PersonalDataApi {
  @JsonKey(name: 'data')
  final Map<String, Data>? data;
  @JsonKey(name: 'meta')
  final Meta? meta;
  @JsonKey(name: 'status')
  String status;

  PersonalDataApi(
      {required this.data, required this.meta, required this.status});

  factory PersonalDataApi.fromJson(Map<String, dynamic> json) {
    final String accountId = json['data'].keys.first;
    return PersonalDataApi(
      data: json['data'] != null
          ? <String, Data>{
              accountId: Data.fromJson(json['data'][accountId]),
            }
          : null,
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
    final Data? privateData = data?[data?.keys.first];
    if (privateData == null) return result;
    result.add(PersonalData(
        dataTitle: 'clanId',
        dataValue: privateData.clanId.toString()));
    result.add(PersonalData(
        dataTitle: 'global_rating',
        dataValue: privateData.globalRating.toString()));

    if (privateData.private == null) return result;
    privateData.private!.privateData.forEach((key, value) {
      result.add(PersonalData(dataTitle: key, dataValue: value.toString()));
    });
    return result;
  }
}
