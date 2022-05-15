// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserPersonalDataApi> fetchPersonalData(
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
        _setStreamType<UserPersonalDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/info/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserPersonalDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ClanInfoDataApi> fetchClanInfo(applicationId, clanId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'clan_id': clanId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ClanInfoDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/clans/info/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ClanInfoDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserVehiclesDataApi> fetchUserVehicles(
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
        _setStreamType<UserVehiclesDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/tanks/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserVehiclesDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VehiclesDataApi> fetchVehiclesDatabase(
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
        _setStreamType<VehiclesDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/encyclopedia/vehicles/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VehiclesDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserAchievesDataApi> fetchUserAchieves(
      applicationId, accountId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'account_id': accountId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserAchievesDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/achievements/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserAchievesDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AchievementsDataApi> fetchAchievesDataBase(
      applicationId, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'language': language
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AchievementsDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/encyclopedia/achievements/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AchievementsDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchUserDataApi> searchUsers(applicationId, search, limit) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'application_id': applicationId,
      r'search': search,
      r'limit': limit
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchUserDataApi>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/list/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchUserDataApi.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TokenExtResponse> tokenExtension(applicationId, accessToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'application_id': applicationId};
    final _headers = <String, dynamic>{};
    final _data = accessToken;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TokenExtResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/auth/prolongate/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TokenExtResponse.fromJson(_result.data!);
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
