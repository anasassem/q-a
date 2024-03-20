part of 'dash_board_imports.dart';

class DashBoardController {
  final TextEditingController termsAnnConditionsAr = TextEditingController();
  final TextEditingController termsAnnConditionsEn = TextEditingController();
  final TextEditingController privacyPolicyAr = TextEditingController();
  final TextEditingController privacyPolicyEn = TextEditingController();
  final TextEditingController notification = TextEditingController();
  final TextEditingController apiKey = TextEditingController();
  final TextEditingController appLink = TextEditingController();
  final GenericBloc<List<dynamic>> imagesBloc = GenericBloc([]);
  final GenericBloc<List<ReviewModel>> reviews = GenericBloc([]);
  final GenericBloc<List<UserModel>> users = GenericBloc([]);
  final GenericBloc<DashBoardModel?> dashBoardData = GenericBloc(null);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DashBoardController(BuildContext context) {
    MoreCubit.get(context).getReviews();
    getAllUsers();
    getDashBoard();
  }


  void getDashBoard() async {
    final data = await firestore.collection("dashBoard").doc("dashBoard").get();
    if (data.data() == null) return;
    final parsedData = DashBoardModel.fromJson(data.data()!);
    dashBoardData.onUpdateData(parsedData);
    appLink.text = parsedData.appLink ?? "";
    termsAnnConditionsAr.text = dashBoardData.state.data?.termsAr ?? "";
    termsAnnConditionsEn.text = dashBoardData.state.data?.termsEn ?? "";
    privacyPolicyAr.text = dashBoardData.state.data?.privacyAr ?? "";
    privacyPolicyEn.text = dashBoardData.state.data?.privacyEn ?? "";
    apiKey.text = dashBoardData.state.data?.apiKey ??"" ;
    imagesBloc.state.data.addAll(dashBoardData.state.data?.images ?? []);
    imagesBloc.onUpdateData(imagesBloc.state.data);
  }

  void updateDashBoard() async {
    var images = [];
    await Future.wait(imagesBloc.state.data.whereType<File>().map(
      (element) async {
        final res = await FirebaseStorage.instance
            .ref()
            .child("users/${Uri.file(element.path).pathSegments.last}")
            .putFile(element);
        final url = await res.ref.getDownloadURL();
        images.add(url);
      },
    ).toList());
    images.addAll(imagesBloc.state.data.whereType<String>());
    try{
      getIt<LoadingHelper>().showLoadingDialog();
      await firestore.collection("dashBoard").doc("dashBoard").set(
        {
          "imgs": images,
          "terms_ar": termsAnnConditionsAr.text,
          "terms_en": termsAnnConditionsEn.text,
          "privacy_ar": privacyPolicyAr.text,
          "privacy_en": privacyPolicyEn.text,
          "api_key": apiKey.text,
          "app_link": appLink.text
        },
      );
      getIt<LoadingHelper>().dismissDialog();
      CustomToast.showSimpleToast(msg: "Data updated successfully");
    } catch  (e){
      log(e.toString());
    }
    GlobalState.instance.set("api_key", apiKey.text);
  }

  Future<File?> getImageFromCamera(BuildContext context) async {
    var image = await getIt<Utilities>().getImageFromCamera(context);
    imagesBloc.state.data.add(image);
    imagesBloc.onUpdateData(imagesBloc.state.data);
    return image;
  }

  Future<void> showGallaryOrCamera(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return BuildAddImageDialog(controller: this);
      },
    );
  }

  Future<void> sendNotification(
      String deviceId, String title, String body) async {
    final Dio dio = DioFactory().getDio();
    try {
      await dio.post(
        "https://fcm.googleapis.com/fcm/send",
        data: {
          "to": deviceId,
          "priority": "high",
          "notification": {
            "title": title,
            "body": body,
            "sound": 'notification.aiff',
            "android_channel_id": "alarm_notification"
          },
          "android": {
            "priority": "HIGH",
            "notification": {
              "notification_priority": "PRIORITY_MAX",
              "sound": "notification",
              "default_vibrate_timings": true,
              "default_light_settings": true
            }
          },
          "data": {
            "type": "order",
            "id": "87",
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAllUsers() async {
    var data = await firestore.collection("users").get();
    users.onUpdateData(data.docs.map((element) {
      return UserModel.fromJson(element.data());
    }).toList());
  }

  Future<List<File>> getRequestImages(BuildContext context) async {
    var images = await getIt<Utilities>().getImages(context);
    if (images != []) {
      imagesBloc.state.data.addAll(images);
      imagesBloc.onUpdateData(imagesBloc.state.data);
      return images;
    } else {
      return [];
    }
  }

  Future<void> removeImage(int index) async {
    imagesBloc.state.data.removeAt(index);
    imagesBloc.onUpdateData(imagesBloc.state.data);
  }

  void showSendNotifyDialog(BuildContext context, String deviceId) {
    showDialog(
      context: context,
      builder: (context) => BuildSendNotifyDialog(
        controller: this,
        deviceId: deviceId,
      ),
    );
  }

  Future<void> setTermsAndConditionsAr(BuildContext context) async {
    try {
      firestore
          .collection("termsAndConditions")
          .doc("pGlT2mGxkdylN1akmauw")
          .update(
        {"terms_ar": termsAnnConditionsAr.text},
      );
      _successDialog(context);
    } catch (e) {
      print("error");
    }
  }  Future<void> setTermsAndConditionsEn(BuildContext context) async {
    try {
      firestore
          .collection("termsAndConditions")
          .doc("pGlT2mGxkdylN1akmauw")
          .update(
        {"terms_en": termsAnnConditionsEn.text},
      );
      _successDialog(context);
    } catch (e) {
      print("error");
    }
  }

  Future<void> setPrivacyPolicyAr(BuildContext context) async {
    try {
      firestore.collection("privacyPolicy").doc("JDjo3ve94fD8b1h3wFFz").update(
        {"privacy_policy": privacyPolicyAr.text},
      );
      _successDialog(context);
    } catch (e) {
      log(e.toString());
    }
  }  Future<void> setPrivacyPolicyEn(BuildContext context) async {
    try {
      firestore.collection("privacyPolicy").doc("JDjo3ve94fD8b1h3wFFz").update(
        {"privacy_policy": privacyPolicyAr.text},
      );
      _successDialog(context);
    } catch (e) {
      log(e.toString());
    }
  }

  void _successDialog(BuildContext context) {
    AwesomeDialog(
      btnOkColor: primaryColor,
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: tr("succes", context),
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  Future<void> getReviews() async {
    try {
      var data = await firestore.collection("reviews").get();
    } catch (e) {
      log(e.toString());
    }
  }
}
