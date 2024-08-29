import 'dart:convert';

import 'package:chatbot_web/utils/resource.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/constants.dart';
import '../models/chat_models.dart';

part 'generator.g.dart';

@RestApi(baseUrl: ApiConstants.BASE_URL) // Değeri dinamik olarak alıyoruz
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  static RestClient create() {
    final dio = Dio();
    RestClient.debugHttpInterceptors(dio); // Burada çağrılıyor
    return RestClient(dio);
  }

  @POST('/chat/completions')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "charset": "utf-8",
  })
  Future<Resource<List<ChatModel>>> sendMessage({required String msg, required String modelId});

  static void debugHttpInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('onRequest');
        debugPrint("--> ${options.method} ${options.uri}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('onResponse');
        debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
        debugPrint("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('onError');
        debugPrint("<-- Error ${e.response?.statusCode} ${e.response?.requestOptions.uri}");
        debugPrint("Message: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
