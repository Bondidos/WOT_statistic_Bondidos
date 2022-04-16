// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wot_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _WotClient implements WotClient {
  _WotClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.worldoftanks.eu';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PersonalApiData> fetchPersonalData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PersonalApiData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/wot/account/info/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PersonalApiData.fromJson(_result.data!);
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
