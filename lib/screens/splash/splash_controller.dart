// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

part of 'splash_imports.dart';

class SplashController {
  var now = DateTime.now();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getApiKey(BuildContext context) async {
    var data = await firestore.collection("dashBoard").doc("dashBoard").get();
    var parsedData = DashBoardModel.fromJson(data.data()!);
    GlobalState.instance.set("api_key", parsedData.apiKey);
  }

  Future<void> handleUserPayment(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    var data = await firestore.collection("users").doc(uid).get();
    var parsedUser = UserModel.fromJson(data.data()!);
    handleUserLang(parsedUser, context);
    if (parsedUser.isPayment == true) {
      if (parsedUser.paymentType == "week") {
        _handleWeekPayment(parsedUser, context);
      } else if (parsedUser.paymentType == "monthly") {
        _handleMonthPayment(parsedUser, context);
      } else if (parsedUser.paymentType == "yearly") {
        _handleYearPayment(parsedUser, context);
      }
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Payment(),
        ),
      );
    }
  }

  void _handleWeekPayment(UserModel user, BuildContext context) async {
    log("data : \n${user.toJson()}");
    final DateTime date = user.paymentDate!.toDate();
    var uid = await GetDeviceId().deviceId;
    if (date.day == now.day - 3 ||
        date.isBefore(
          DateTime(
            now.year,
            now.month,
            now.day - 3,
          ),
        ) ||
        date.isBefore(
          DateTime(
            now.year,
            now.month,
            now.day - 7,
          ),
        )) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "payment_type": "week",
        "used_free": true,
        "is_payment": false,
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Payment(),
        ),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
    }
  }

  void _handleMonthPayment(UserModel user, BuildContext context) async {
    final DateTime date = user.paymentDate!.toDate();
    var uid = await GetDeviceId().deviceId;
    if (date.month == now.month - 1 ||
        date.isBefore(
          DateTime(
            now.year,
            now.month - 1,
            now.day,
          ),
        )) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "payment_type": "monthly",
        "is_payment": false,
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Payment(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
    }
  }

  void _handleYearPayment(UserModel user, BuildContext context) async {
    final DateTime date = user.paymentDate!.toDate();
    var uid = await GetDeviceId().deviceId;
    if (date.year == now.year - 1 ||
        date.isBefore(
          DateTime(
            now.year - 1,
            now.month,
            now.day,
          ),
        )) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "payment_type": "yearly",
        "is_payment": false,
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
    }
  }

  void manipulateSaveData(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    bool isLogged = await isLogin();
    if (isLogged) {
      getApiKey(context);
      handleUserPayment(context);
      Future.delayed(
        Duration(seconds: 1),
        () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Home(
              deviceId: uid!,
            ),
          ),
        ),
      );
    } else {
      getApiKey(context);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => SelectLang(),
          ),
        );
      });
    }
  }

  Future<bool> isLogin() async {
    var users = await FirebaseFirestore.instance.collection("users").get();
    if (users.docs.isNotEmpty) {
      var uid = await GetDeviceId().deviceId;
      return users.docs.any((e) {
        if (e.id == uid) {
          return true;
        } else {
          return false;
        }
      });
    } else {
      return false;
    }
  }
  void handleUserLang(UserModel user, BuildContext context) {
    if (user.lang != null) {
      context.read<LangCubit>().onUpdateLanguage(Locale(user.lang!));
    }
  }
}
