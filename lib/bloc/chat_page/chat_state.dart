import 'package:chatbot_web/bloc/chat_page/chat_cubit.dart';

import '../../models/chat_models.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  // List<ChatModel> chatList = [ChatModel(msg: "How to make creeps", chatIndex: 0)];
  List<ChatModel> chatList = [];
  // List<ChatModel> chatList = [ChatModel(msg: content, chatIndex: 1)];
  List<ChatModel> get getchatList => chatList; // bunu koymalı mıyım?

  ChatSuccess({required this.chatList});
}

class ChatError extends ChatState {}
