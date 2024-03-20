
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/bloc/generic_cubit/generic_cubit.dart';
import 'package:testqa/core/constants/dimens.dart';
import 'package:testqa/core/constants/gaps.dart';
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/core/widgets/custom_decoration.dart';
import 'package:testqa/models/dash_board_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testqa/res.dart';

part 'home_main.dart';
part 'home_main_controller.dart';