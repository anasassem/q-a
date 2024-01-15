import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/screens/home/tabs/chat_screen/chat.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';



part 'ocr.dart';
part 'ocr_controller.dart';
