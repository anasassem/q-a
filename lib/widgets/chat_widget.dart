// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/helpers/custom_toast.dart';
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/models/user_model.dart';
import 'package:testqa/res.dart';
import 'package:testqa/services/assets_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
    this.isMath = false,
    required this.listScrollController,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  final bool isMath;
  final ScrollController listScrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: msg));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    chatIndex == 0 ? AssetsManager.userImage : Res.logo,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: chatIndex == 0
                        ? TextWidget(
                            isMath: isMath,
                            label: msg,
                          )
                        : shouldAnimate
                            ? GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: msg));
                                },
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                  child: AnimatedTextKit(
                                    onNext: (int i, bool x) {
                                      listScrollController.animateTo(
                                        listScrollController
                                            .position.maxScrollExtent,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeOut,
                                      );
                                    },
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: msg));
                                    },
                                    isRepeatingAnimation: false,
                                    repeatForever: false,
                                    displayFullTextOnTap: true,
                                    totalRepeatCount: 0,
                                    onFinished: () async {
                                      var firestore =
                                          FirebaseFirestore.instance;
                                      var uid = await GetDeviceId().deviceId;
                                      var user = await FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(uid)
                                          .get();
                                      await firestore
                                          .collection("chatHistory")
                                          .doc(uid)
                                          .collection("items")
                                          .add({
                                        "questions": chatIndex,
                                        "answer": ""
                                      });
                                      var parsedUser =
                                          UserModel.fromJson(user.data()!);
                                      if (parsedUser.isPayment == false) {
                                        // ignore: use_build_context_synchronously
                                        CustomToast.showPaymentDialog(context);
                                      }
                                    },
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        msg.trim(),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Text(
                                msg.trim(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                  ),
                  chatIndex == 0
                      ? InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: msg,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.copy,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: msg,
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
