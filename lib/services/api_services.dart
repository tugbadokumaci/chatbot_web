// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:chatbot_web/service_locator.dart';
// import 'package:chatbot_web/utils/generator.dart';

// import '../models/chat_models.dart';
// import '../models/openAPIModel_model.dart';

// import 'package:http/http.dart' as http;

// const String _BASE_URL = "https://api.openai.com/v1";

// mixin MixinApiFeature {
//   final RestClient _client;

//   Future<List<OpenApiModel>> getModel() async {
//     try {
//       var response = await http.get(
//         Uri.parse("$_BASE_URL/models"),
//         headers: {"Authorization": "Bearer $_Api_key"},
//       );
//       Map jsonResponse = jsonDecode(response.body);
//       if (jsonResponse["error"] != null) {
//         throw HttpException(jsonResponse["error"]["message"]);
//       }
//       List temp = [];
//       for (var value in jsonResponse["data"]) {
//         temp.add(value);
//         //log("model: $value");
//       }
//       return OpenApiModel.modelsFromSnapshot(temp);
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }

//   Future<List<ChatModel>> sendMessage({required String msg, required String modelId}) async {
//     try {
//       var response = await http.post(Uri.parse("$_BASE_URL/chat/completions"),
//           headers: {"Content-Type": "application/json", "Authorization": "Bearer $_Api_key"},
//           body: jsonEncode({
//             "model": modelId,
//             "messages": [
//               {"role": "user", "content": msg}
//             ],
//           }));

//       Map jsonResponse = jsonDecode(response.body);
//       if (jsonResponse["error"] != null) {
//         throw HttpException(jsonResponse["error"]["message"]);
//       }
//       List<ChatModel> chatList = [];
//       if (jsonResponse["choices"].length > 0) {
//         //log("Message: ${jsonResponse["choices"][0]["text"]}");
//         chatList = List.generate(
//           jsonResponse["choices"].length,
//           (index) => ChatModel(
//             msg: jsonResponse["choices"][index]["text"],
//             chatIndex: 1,
//           ),
//         );
//       }
//       return chatList;
//     } catch (e) {
//       log(e.toString());
//       rethrow;
//     }
//   }
// }
