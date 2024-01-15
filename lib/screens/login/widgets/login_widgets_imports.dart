import 'dart:convert';

import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/bloc/generic_cubit/generic_cubit.dart';
import 'package:testqa/core/constants/dimens.dart';
import 'package:testqa/core/constants/gaps.dart';
import 'package:testqa/core/helpers/custom_toast.dart';
import 'package:testqa/core/helpers/validator.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/core/widgets/generic_text_field.dart';
import 'package:testqa/res.dart';
import 'package:testqa/screens/register/register_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../login_imports.dart';


part 'build_login_form.dart';
part 'build_login_button.dart';
part 'build_social_item.dart';
part 'build_register_btn.dart';
part 'build_sign_in_with_google.dart';
part 'build_login_header.dart';