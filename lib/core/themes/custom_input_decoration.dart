import 'package:testqa/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';



class CustomInputDecoration extends InputDecoration {
  final String lang;
  final String? labelTxt;
  final String? hint;
  final Widget? prefIcon;
  final Widget? sufIcon;
  final Color? enableColor;
  final Color? focsColor;
  final Color? hintColor;
  final Color? customFillColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final bool? allowDense;

  const CustomInputDecoration(
      {required this.lang,
        this.hint,
        this.labelTxt,
        this.prefIcon,
        this.sufIcon,
        this.hintColor,
        this.customFillColor,
        this.enableColor,
        this.focsColor,
        this.borderRadius,
        this.allowDense = false,
        this.padding})
      : super();

  @override
  InputBorder get enabledBorder => OutlineInputBorder(
    borderSide:
    BorderSide(color: enableColor ?? Colors.grey.withOpacity(0.25), width: .7),
    borderRadius: borderRadius ?? BorderRadius.circular( 10),
  );

  @override
  InputBorder get focusedBorder => OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular( 10),
      borderSide: BorderSide(color: focusColor ?? Colors.black, width: 1));

  @override
  InputBorder get errorBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: .5),
      borderRadius: borderRadius ?? BorderRadius.circular( 10));

  @override
  InputBorder get focusedErrorBorder => OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular( 10),
      borderSide: const BorderSide(color: Colors.red, width: 2));

  @override
  TextStyle get errorStyle => const AppTextStyle.s12_w400(color: Colors.red);

  @override
  String? get hintText => hint;

  @override
  Widget? get label => labelTxt==null?super.label:Text(labelTxt??"",style: labelStyle,);

  @override
  TextStyle get labelStyle => const AppTextStyle.s16_w400(color: Colors.grey);

  @override
  TextStyle? get hintStyle => AppTextStyle.s16_w400(color: hintColor ?? Colors.grey);

  @override
  EdgeInsetsGeometry get contentPadding =>
      padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 18);

  @override
  bool get filled => true;

  @override
  Color get fillColor => customFillColor ?? Colors.white;

  @override
  bool get alignLabelWithHint => true;

  @override
  Widget? get suffixIcon => sufIcon;

  @override
  Widget? get prefixIcon => prefIcon;

  @override
  Color? get focusColor => focsColor;

  @override
  bool? get isDense => allowDense;

}
