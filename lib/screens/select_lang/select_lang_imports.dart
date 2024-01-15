import 'dart:convert';
import 'dart:io';

import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/bloc/generic_cubit/generic_cubit.dart';
import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:testqa/core/constants/gaps.dart';
import 'package:testqa/core/helpers/di.dart';
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/core/helpers/utilities.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/screens/home/home_imports.dart';

import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'select_lang.dart';
part 'select_lang_controller.dart';