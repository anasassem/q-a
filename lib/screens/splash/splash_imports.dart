
import 'dart:developer';

import 'package:testqa/core/bloc/api_key_bloc/api_key_cubit.dart';
import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:testqa/core/helpers/get_device_id.dart';
import 'package:testqa/core/helpers/global_state.dart';
import 'package:testqa/models/dash_board_model.dart';
import 'package:testqa/models/user_model.dart';
import 'package:testqa/res.dart';
import 'package:testqa/screens/dash_board/dash_board_imports.dart';
import 'package:testqa/screens/home/home_imports.dart';
import 'package:testqa/screens/home/tabs/more/widgets/more_w_imports.dart';
import 'package:testqa/screens/login/login_imports.dart';
import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:testqa/screens/select_lang/select_lang_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

part 'splash.dart';
part 'splash_controller.dart';