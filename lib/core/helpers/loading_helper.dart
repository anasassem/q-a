import 'dart:ui';

import 'package:testqa/core/widgets/app_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class LoadingHelper {
  void showLoadingDialog() {
    if(!EasyLoading.isShow) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: false,
      );
    }
  }

  void initConfig(){
    EasyLoading.instance
      ..indicatorWidget = const _LoadingDialogOverly()
      ..backgroundColor = Colors.white
      ..textColor = Colors.white
      ..indicatorColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.light
      ..contentPadding = EdgeInsets.zero;
  }


  Widget showLoadingView() {
    return const Center(
      child: SpinKitFoldingCube(
        color: Colors.black,
        size: 40.0,
      ),
    );
  }

  Widget showCatLoadingView() {
    return const Center(
      child: SpinKitRipple(
        color: Colors.black,
        size: 40.0,
      ),
    );
  }

  void dismissDialog() {
    EasyLoading.dismiss();
  }

  void showInvalidSession() {}


}


class _LoadingDialogOverly extends StatelessWidget {
  const _LoadingDialogOverly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.white,
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          const Material(
              color: Colors.transparent,
              child: AppLoaderWidget(),
          ),
        ],
      ),
    );
  }
}
