// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../core/localization/localization_methods.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../models/user_model.dart';
import '../../../../providers/chats_provider.dart';
import '../../../../providers/models_provider.dart';
import '../../../../res.dart';
import '../../../../services/services.dart';
import '../../../../widgets/chat_widget.dart';
import '../../../../widgets/text_widget.dart';

class ChatScreen extends StatefulWidget {
  final String? scannedText;

  final String? sourcePath;

  const ChatScreen({super.key, this.scannedText, this.sourcePath});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  String question = "";

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  // List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(Res.logo),
        ),
        centerTitle: true,
        title: const Text("Chat Q & A",
            style: AppTextStyle.s16_w700(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _listScrollController,
                child: Column(
                  children: List.generate(
                    chatProvider.getChatList.length,
                    (index) => ChatWidget(
                      msg: chatProvider.getChatList[index].msg,
                      // chatList[index].msg,
                      chatIndex: chatProvider.getChatList[index].chatIndex,
                      //chatList[index].chatIndex,
                      shouldAnimate:
                          chatProvider.getChatList.length - 1 == index,
                      listScrollController: _listScrollController,
                    ),
                  ),
                ),
              ),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: primaryColor,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        maxLines: null,
                        style: TextStyle(color: primaryColor),
                        controller: textEditingController,
                        // onSubmitted: (value) async {
                        //   await sendMessageFCT(
                        //     modelsProvider: modelsProvider,
                        //     chatProvider: chatProvider,
                        //   );
                        // },
                        decoration: InputDecoration.collapsed(
                          hintText: tr("howCanIHelpU", context),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessageFCT(
                          isFormImage: false,
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      icon: Icon(
                        Icons.send,
                        color: primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await Permission.camera.isGranted) {
                          runFilePiker(ImageSource.camera);
                        } else {
                          await Permission.camera.request();
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text(
                                      "choose the type of the image"),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          //runFilePiker(ImageSource.gallery);
                                          var image = await pickImage();
                                          if (image != null) {
                                            await uploadImage(
                                                image, context, "m");
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: primaryColor),
                                          child: Text(
                                            "Math Eqution",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          //runFilePiker(ImageSource.gallery);
                                          var image = await pickImage();
                                          if (image != null) {
                                            await uploadImage(
                                                image, context, "l");
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.grey),
                                          child: Text("Simple Text"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      icon: Icon(
                        Icons.camera,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void runFilePiker(ImageSource) async {
    // android && ios only
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource, requestFullMetadata: true);
    if (pickedFile != null) {
      await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      /* _ocr(croppedFile, "m");*/
    }
  }

  bool bload = false;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      return File(croppedFile!.path);
    }
    return null;
  }

  Future<void> uploadImage(
      imageFile, BuildContext context, String imageType) async {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    String apiUrl = "https://pyocr-b3169decc152.herokuapp.com/ocr";
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
      'image', // The field name for file in your API
      imageFile!.path,
    ));
    request.fields['language'] = imageType;
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        question = jsonDecode(responseBody.body)["result"];
        log(question);
        String textBefore = question;
        if (imageType == "m") {
          question = "write the equation and solve it $textBefore";
        }

        sendMessageFCT(
          isFormImage: true,
          modelsProvider: modelsProvider,
          chatProvider: chatProvider,
        );
      } else {
        log("Image upload failed");
      }
    } catch (e) {
      log("Error occurred: $e");
    }
  }

// Usage

/*  OcrModel? ocrDate;

  void _ocr(image, messageType) async {

    XFile file = XFile('assets/test.jpeg');
    //await file.writeAsBytes(bytes);
    image = file;
    print(image);
    try {
      var response = await http.post(
          Uri.parse("https://pyocr-b3169decc152.herokuapp.com/ocr"),
          body: {"image": file, "language": "m"});
      print("########${response.body}");

      bload = true;
      setState(() {});
    } catch (e) {
      print(e);
      bload = false;
      setState(() {});
    }
  }*/

  void scrollListToEND() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  String _question(bool isFromImage) {
    if (isFromImage) {
      return question;
    } else {
      return textEditingController.text;
    }
  }

  Future<void> sendMessageFCT({
    required bool isFormImage,
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: tr("youCantSendMultiMsgs", context),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_question(isFormImage).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: tr("plzTypeAMsg", context),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String msg = _question(isFormImage);
      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        if (!isFormImage) {
          textEditingController.clear();
        }
        focusNode.unfocus();
      });
      var uid = await GetDeviceId().deviceId;
      var user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      var parsedUser = UserModel.fromJson(user.data()!);
      if (parsedUser.paymentType == "none") {
        if (parsedUser.usedFree == true) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Payment(),
            ),
          );
          return;
        }
        if (parsedUser.isPayment == false) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Payment(),
          ));
          return;
        }
        if (chatProvider.chatList.length >= 6) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .update({"used_free": true});
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Payment(),
            ),
          );
          return;
        }
      }
      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
        tokens: parsedUser.isPayment == true ? 4000 : 200,
      );
      _isTyping = false;
      await firestore.collection("history").doc(uid).collection("history").add(
        {"msg": msg.trim()},
      );
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
