import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg, required bool isMath}) {
    chatList.add(ChatModel(isMath: isMath, msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required int tokens,
      required String msg,
      required bool isMath,
      required String chosenModelId}) async {
    msg = isMath ? "write math problem and solve it $msg" : msg;
    if (chosenModelId.toLowerCase().startsWith("gpt")) {
      chatList.addAll((await ApiService.sendMessageGPT(
        isMath: isMath,
        message: msg,
        modelId: chosenModelId,
        tokens: tokens,
      )));
    } else {
      chatList.addAll((await ApiService.sendMessage(
        isMath: isMath,
        message: msg,
        tokens: tokens,
        modelId: chosenModelId,
      )));
    }
    notifyListeners();
  }
}
