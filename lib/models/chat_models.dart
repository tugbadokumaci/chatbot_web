import 'package:json_annotation/json_annotation.dart';

part 'chat_models.g.dart';

@JsonSerializable()
class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({
    required this.msg,
    required this.chatIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['message']?['content'] ?? '', // Default to empty string if null
        chatIndex: json['index'] ?? -1, // Default to 0 if null
      );
}
