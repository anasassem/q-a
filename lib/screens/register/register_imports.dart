import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:testqa/core/constants/dimens.dart';
import 'package:testqa/core/helpers/custom_toast.dart';
import 'package:testqa/core/helpers/di.dart';
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/core/helpers/loading_helper.dart';
import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/core/themes/app_text_style.dart';
import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:testqa/screens/register/widgets/cus_register_w_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'register.dart';
part 'register_controller.dart';