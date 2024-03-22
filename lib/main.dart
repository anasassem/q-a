import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:testqa/core/bloc/lang_cubit/lang_cubit.dart';
import 'package:testqa/core/helpers/app_notfications.dart';
import 'package:testqa/core/helpers/di.dart';
import 'package:testqa/core/helpers/loading_helper.dart';
import 'package:testqa/core/localization/localization.dart';
import 'package:testqa/providers/models_provider.dart';
import 'package:testqa/screens/splash/splash_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'core/helpers/dio_helper.dart';
import 'firebase_options.dart';
import 'providers/chats_provider.dart';
import 'screens/home/tabs/more/more_cubit/more_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppNotifications().setupNotification();
  await configureDependencies();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getIt.get<LoadingHelper>().initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoreCubit>(
          create: (BuildContext context) => MoreCubit(),
        ),
        BlocProvider<LangCubit>(
          create: (BuildContext context) => LangCubit(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
        ],
        child: BlocBuilder<LangCubit, LangState>(
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
              localizationsDelegates: const [
                SetLocalization.localizationsDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: state.locale,
              title: 'Flutter ChatBOT',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: scaffoldBackgroundColor,
                  appBarTheme: AppBarTheme(
                    color: cardColor,
                  )),
              home: const Splash(),
              builder: EasyLoading.init(
                builder: (ctx, child) {
                  ScreenUtil.init(ctx);
                  return child!;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
