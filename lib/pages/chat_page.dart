import 'package:chat_app_bloc/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app_bloc/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app_bloc/model/message_model.dart';
import 'package:chat_app_bloc/widgets/chat_bubble.dart';
import 'package:chat_app_bloc/widgets/chat_bubble_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  TextEditingController textController = TextEditingController();

  final _scrollController = ScrollController();

  List<MessageModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2B475E),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset("assets/images/scholar.png"),
            ),
            const Text(
              " chat",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              // First Solution to get MsgList from ChatSuccessState
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                }
              },
              builder: (context, state) {
                // Second Solution to get MsgList from ChatCubit
                // var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;

                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    if (messagesList[index].email == email) {
                      return ChatBubble(message: messagesList[index]);
                    } else {
                      return ChatBubbleFriend(message: messagesList[index]);
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: textController,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(email: email.toString(), message: data);

                textController.clear();
                _scrollController.animateTo(0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (textController.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          email: email.toString(),
                          message: textController.text);

                      textController.clear();
                      _scrollController.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: const Icon(Icons.send),
                ),
                iconColor: const Color(0xff2B475E),
                hintText: "Type a Message",
                border: const OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
