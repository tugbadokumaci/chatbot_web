import 'package:chatbot_web/bloc/chat_page/chat_repository.dart';
import 'package:chatbot_web/utils/generator.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

class DependencyInjection {
  DependencyInjection() {
    provideRepositories();
  }

  void provideRepositories() {
    locator.registerSingleton<Dio>(Dio());
    locator.registerSingleton<RestClient>(RestClient(locator<Dio>()));
    locator.registerFactory<ChatRepository>(() => ChatRepository(locator<RestClient>()));
  }
}
