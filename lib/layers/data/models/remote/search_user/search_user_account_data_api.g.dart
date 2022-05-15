// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_account_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserAccountDataApi _$SearchUserAccountDataApiFromJson(
        Map<String, dynamic> json) =>
    SearchUserAccountDataApi(
      accountId: json['account_id'] as int,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$SearchUserAccountDataApiToJson(
        SearchUserAccountDataApi instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'nickname': instance.nickname,
    };
