import 'package:chat_app_bloc/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app_bloc/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection("messages");

  // Second Solution to get MsgList from ChatCubit
  // List<MessageModel> messagesList = [];

  void sendMessage({required String email, required String message}) {
    messages.add(
      {
        'message': message,
        'createdAt': DateTime.now(),
        'email': email,
      },
    );
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      // First Solution to get MsgList from ChatSuccessState
      List<MessageModel> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    });

    // Second Solution to get MsgList from ChatCubit

    /* 

    messagesList.clear();

    for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    
    */
  }
}
