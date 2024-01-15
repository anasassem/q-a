import 'dart:io';

import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


@lazySingleton
class Utilities{
  Future<List<File>> getImages(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final ImagePicker picker = ImagePicker();
    final List<XFile> photos = await picker.pickMultiImage();
    if (photos.isNotEmpty) {
      List<File> imagesFile = photos.map((e) => File(e.path)).toList();
      return imagesFile;
    } else {
      return [];
    }
  }

  Future<void> changeLanguage(String lang, BuildContext context) async {
    context.read <LangCubit>().onUpdateLanguage(Locale(lang));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", lang);
  }

  Future<File> getImageFromCamera(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    File imageFile = File(photo!.path);
    return imageFile;
  }
}