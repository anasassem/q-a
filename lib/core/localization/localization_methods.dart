import 'package:testqa/core/localization/localization.dart';
import 'package:flutter/material.dart';

String tr(String key,  BuildContext context) {
  return SetLocalization.of(context)!.getTranslateValue(key);
}
