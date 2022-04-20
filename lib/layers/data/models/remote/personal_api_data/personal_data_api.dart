import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entities/personal_data.dart';
import 'data.dart';

part 'personal_data_api.g.dart';

@JsonSerializable()
class PersonalDataApi {
  @JsonKey(name: 'data')
  final Map<String, Data>? data;
  @JsonKey(name: 'status')
  String status;

  PersonalDataApi({required this.data, required this.status});

  factory PersonalDataApi.fromJson(Map<String, dynamic> json) =>
      _$PersonalDataApiFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDataApiToJson(this);

  List<PersonalData> toList() {
    /*List<PersonalData> result = [];
    final Data? privateData = data?[data?.keys.first];
    if (privateData == null) return result;
    result.add(PersonalData(
        dataTitle: 'clanId', dataValue: privateData.clanId.toString()));
    result.add(PersonalData(
        dataTitle: 'global_rating',
        dataValue: privateData.globalRating.toString()));

    if (privateData.private == null) return result;
    privateData.private!.privateData.forEach((key, value) {
      result.add(PersonalData(dataTitle: key, dataValue: value.toString()));
    });*/
    return [];
  }
}
