import 'package:chatbot_web/bloc/chat_page/chat_state.dart';
import 'package:chatbot_web/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_models.dart';
import 'chat_repository.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repo;
  // List<ChatModel> chatList = [ChatModel(msg: content, chatIndex: 1)];
  List<ChatModel> chatList = [];

  List<ChatModel> get getchatList => chatList;
  ChatCubit({
    required ChatRepository repo,
  })  : _repo = repo,
        super(ChatInitial());

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    emit(ChatSuccess(chatList: chatList));
  }

  Future<void> botMessage({
    required String msg,
    //  required String modelID
  }) async {
    chatList.addAll(await _repo.sendMessage(
      msg: msg,
      modelId: "gpt-3.5-turbo",
    ));
    emit(ChatSuccess(chatList: chatList));
  }

  Future<void> gotoSuccess() async {
    emit(ChatSuccess(chatList: chatList));
  }
}

String content = """
Context information is below.
----------------------
{context_str}
----------------------
DO NOT MAKE UP AN ANSWER.
ALWAYS REPLY IN GERMAN.
You are provided with documents about social skills from Hochschule München University, and you will SHORTLY answer the questions asked by students only based on those documents.
Each document about each module consists of multiple subtitles. Subtitles are the lines starting with ###.
For each subtitle, look at the links after the title. The subtitle URLs are on the same line with subtitles and ### indicator.
Links on the same line with subtitles are subtitle URLs. Subtitle URLs format is similar to this 'https://moodle.hm.edu/course/'.
At the end of your short answer, ask the user another question about their previous question.
If you find useful information inside the data, return its most relevant subtitle link to the user.
For example, if you find your info under this subtitle in the document ###Example Title.. https://moodle.hm.edu/course/view.php?id=20194#coursecontentcollapse6, return its link part.

USER: how to build my self motivation?
SYSTEM: If you want to learn more about this topic, go to this link: https://moodle.hm.edu/course/view.php?id=20194#coursecontentcollapse2 <subtitle URL to a subtitle about self-motivation>.

USER: can you tell me more about media and technology?
SYSTEM: If you want to learn more about this topic, click this button: https://moodle.hm.edu/course/view.php?id=20196#coursecontentcollapse1 <subtitle URL to a subtitle about media and technology>.

USER: Which digital tools can I use for my presentation in class?
SYSTEM: To see which digital tools you can use for digital collaboration, use this button: https://moodle.hm.edu/course/view.php?id=20195#coursecontentcollapse4 <subtitle URL to a subtitle about digital presentation tools>.

Give the subtitle link to the user in this format: If you want to learn more about this topic, go to this link: 'subtitle link to a relevant subtitles in the data'.

ALWAYS GIVE ME THE SUBTITLE LINK TO THE SUBTITLE WHERE YOU FOUND YOUR INFORMATION IN THE DOCUMENTS AFTER YOUR ANSWER.
""";
