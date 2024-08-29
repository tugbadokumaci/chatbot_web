import 'dart:developer';

import 'package:chatbot_web/bloc/chat_page/chat_state.dart';
import 'package:chatbot_web/size_config.dart';
import 'package:chatbot_web/utils/custom_colors.dart';
import 'package:chatbot_web/utils/custom_text_styles.dart';
import 'package:chatbot_web/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../services/services.dart';
import '../../utils/app_colors.dart';
import '../../widgets/chat_widget.dart';
import 'chat_cubit.dart';

class ChatView extends StatefulWidget {
  ChatCubit viewModel;
  ChatView({super.key, required this.viewModel});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  bool _isTyping = false;

  late TextEditingController _textEditingController;
  late ScrollController scrollController;

  late FocusNode focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    focusNode = FocusNode();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    // debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: BlocConsumer<ChatCubit, ChatState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        debugPrint('Chat View State is : $state');
        if (state is ChatInitial) {
          // widget.viewModel.addUserMessage(msg: 'how to make creeps');
          widget.viewModel.gotoSuccess();
          return Container();
        } else if (state is ChatLoading) {
          return _buildLoading();
        } else if (state is ChatSuccess) {
          return _buildSuccess(context, state);
        } else if (state is ChatError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
  }

  Widget _buildLoading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          color: Colors.yellow,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hata ile karşılaşıldı', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
        Container(
            color: Colors.black,
            child: const Align(
              alignment: Alignment.center,
              child: Text('Error'),
            )),
      ],
    ));
  }

  Widget _buildSuccess(BuildContext context, ChatSuccess state) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/logo.png"),
        ),
        title: const Text("ChatGPT"),
        actions: [
          // IconButton(
          //     onPressed: () async {
          //       await Services.showBottomSheet(context: context);
          //     },
          //     icon: const Icon(
          //       Icons.more_vert_rounded,
          //       color: Colors.white,
          //     ))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: state.getchatList.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                return ChatWidget(
                  msg: state.getchatList[index].msg,
                  index: state.getchatList[index].chatIndex,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            SpinKitThreeBounce(
              color: Colors.white,
              size: 50.0,
              controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            )
          ],
          const SizedBox(height: 15),
          Container(
            color: AppColors.cardColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: _textEditingController,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (value) async {
                      await sendMessages(context: context);
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: "How can i help you", hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessages(context: context);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessages({required BuildContext context}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomTextWidget(
            label: "You can't send multiple messages.",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomTextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String sendMsg = _textEditingController.text;
      setState(() {
        _isTyping = true;
        context.read<ChatCubit>().addUserMessage(msg: sendMsg);
        _textEditingController.clear();
        focusNode.unfocus();
      });
      await context.read<ChatCubit>().botMessage(
            msg: sendMsg,
            // modelID: provider.currentModel,
          );
      setState(() {});
    } catch (e) {
      log("error is: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomTextWidget(
          label: e.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollToEnd();
        _isTyping = false;
      });
    }
  }
}
