import 'package:chatbot_web/utils/generator.dart';
import '../../models/chat_models.dart';
import '../../utils/resource.dart';

class ChatRepository {
  final RestClient _client;

  ChatRepository(this._client);

  Future<List<ChatModel>> sendMessage({required String msg, required String modelId}) async {
    try {
      // Assuming the response contains a Resource object with a 'data' property that holds the list of ChatModel
      final response = await _client.sendMessage(msg: msg, modelId: modelId);
      if (response.status == Status.SUCCESS) {
        return response.data ?? [];
      } else {
        throw Exception(response.errorMessage ?? 'An error occurred');
      }
    } catch (e) {
      // Optionally log the error
      rethrow;
    }
  }
}
