class MessageModel {
  final String message, email;

  MessageModel({required this.message, required this.email});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(message: jsonData['message'], email: jsonData['email']);
  }
}
