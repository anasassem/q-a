import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/bloc/generic_cubit/generic_cubit.dart';
import 'package:testqa/core/constants/dimens.dart';
import 'package:testqa/core/constants/enums.dart';
import 'package:testqa/core/constants/gaps.dart';
import 'package:testqa/core/helpers/custom_toast.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/core/widgets/custom_decoration.dart';
import 'package:testqa/models/user_model.dart';
import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'build_pay_options.dart';