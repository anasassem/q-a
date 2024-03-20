class ChatModel {
  final String msg;
  final int chatIndex;
  final bool isMath;

  ChatModel({required this.isMath, required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        isMath: json["isMath"],
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );
}
