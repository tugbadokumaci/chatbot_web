// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.openai.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Resource<List<ChatModel>>> sendMessage({
    required String msg,
    required String modelId,
  }) async {
    try {
      final _extra = <String, dynamic>{};
      final queryParameters = <String, dynamic>{};
      final _headers = <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.API_KEY}', // Ensure API key is securely stored
        'charset': 'utf-8',
      };
      _headers.removeWhere((k, v) => v == null);

      final data = json.encode({
        "model": modelId,
        "messages": [
          {"role": "user", "content": msg}
        ],
      });

      // Debugging: Print the data being sent
      print('Sending request with data: $data');
      print('Headers: $_headers');

      final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Resource<List<ChatModel>>>(
          Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json',
          )
              .compose(
                _dio.options,
                '/chat/completions',
                queryParameters: queryParameters,
                data: data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        ),
      );

      debugPrint('_result: $_result');

      final List<dynamic> jsonData = _result.data?['choices'] ?? [];
      debugPrint('jsonData: $jsonData');

      final List<ChatModel> chatModels = jsonData.map((e) => ChatModel.fromJson(e)).toList();
      debugPrint('chatModels: $chatModels');

      // Debugging: Print the response data
      print('Received response data: ${_result.data}');

      return Resource.success(chatModels);
    } catch (e) {
      print('Exception caught: $e');
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          return Resource.error('Invalid credentials', e.response?.statusCode);
        } else if (e.response?.statusCode == 400) {
          return Resource.error(e.response?.statusMessage ?? 'Bad request', e.response?.statusCode);
        } else if (e.response?.statusCode == 403) {
          return Resource.error(e.response?.statusMessage ?? 'Forbidden', e.response?.statusCode);
        }
      }
      return Resource.error('Please check your internet connection', null);
    }
  }

  // final _value = Resource<List<ChatModel>>.fromJson(_result.data!);
  // return _value;

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
