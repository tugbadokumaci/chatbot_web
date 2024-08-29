import 'package:chatbot_web/bloc/chat_page/chat_cubit.dart';
import 'package:chatbot_web/bloc/chat_page/chat_repository.dart';
import 'package:chatbot_web/bloc/chat_page/chat_view.dart';
import 'package:chatbot_web/constants/constants.dart';
import 'package:chatbot_web/service_locator.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chatRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ChatView(viewModel: ChatCubit(repo: locator.get<ChatRepository>())));
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
