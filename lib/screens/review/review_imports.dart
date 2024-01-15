import 'package:testqa/constants/constants.dart';
import 'package:testqa/core/constants/dimens.dart';
import 'package:testqa/core/helpers/di.dart';
import 'package:testqa/core/helpers/loading_helper.dart';
import 'package:testqa/core/helpers/validator.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/widgets/generic_text_field.dart';
import 'package:testqa/models/review_model.dart';
import 'package:testqa/screens/home/tabs/more/more_cubit/more_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/gaps.dart';
import '../../core/themes/app_text_style.dart';

part 'review_controller.dart';
part 'review.dart';