// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wot_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _WotClient implements WotClient {
  _WotClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PersonalDataApi> fetchPersonalData(
      applicationId, accountId, accessToken, fields) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'account_id': accountId,
      r'access_token': accessToken,
      r'fields': fields
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PersonalDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/info/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PersonalDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ClanInfo> fetchClanInfo(applicationId, clanId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'clan_id': clanId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ClanInfo>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/clans/info/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ClanInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserVehiclesApi> fetchUserVehicles(
      applicationId, accountId, accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'account_id': accountId,
      r'access_token': accessToken
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserVehiclesApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/tanks/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserVehiclesApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VehiclesData> fetchVehiclesDatabase(
      applicationId, fields, limit, pageNumber, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'fields': fields,
      r'limit': limit,
      r'page_no': pageNumber,
      r'language': language
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VehiclesData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/encyclopedia/vehicles/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VehiclesData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserAchievesApi> fetchUserAchieves(applicationId, accountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'account_id': accountId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserAchievesApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/achievements/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserAchievesApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AchievementsDataBase> fetchAchievesDataBase(applicationId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'application_id': applicationId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AchievementsDataBase>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/encyclopedia/achievements/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AchievementsDataBase.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
