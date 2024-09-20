import 'package:chat_app_bloc/model/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
// First Solution to get MsgList from ChatSuccessState

  List<MessageModel> messagesList = [];

  ChatSuccess({required this.messagesList});
}
