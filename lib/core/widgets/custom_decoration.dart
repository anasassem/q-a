import 'package:testqa/core/constants/dimens.dart';
import 'package:flutter/material.dart';

class CustomDecoration extends BoxDecoration {
  @override
  Color? get color => Colors.white;

  @override
  BorderRadiusGeometry? get borderRadius => Dimens.borderRadius5PX;

  @override
  List<BoxShadow>? get boxShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(.3),
          blurRadius: 1,
          spreadRadius: .5,
        )
      ];
}
