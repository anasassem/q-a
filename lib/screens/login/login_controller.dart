// ignore_for_file: use_build_context_synchronously

part of 'login_imports.dart';

class LoginController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GenericBloc<bool> rememberMeBloc = GenericBloc(false);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  Future signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        _setSignIn(context);
      } on FirebaseAuthException catch (e) {
        _handleException(context, e);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  void _setSignIn(BuildContext context) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    if (credential.user != null) {
      getIt<LoadingHelper>().dismissDialog();
      handleUserPayment(context);
    }
  }

  void _handleException(BuildContext context, dynamic e) {
    if (e.code == 'weak-password') {
      getIt<LoadingHelper>().dismissDialog();
      AwesomeDialog(
        context: context,
        title: "Error",
        body: const Text(
          'Password is week',
          style: AppTextStyle.s12_w500(color: Colors.black),
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      getIt<LoadingHelper>().dismissDialog();
      AwesomeDialog(
        context: context,
        title: "Error",
        body: const Text(
          'Email is already in use',
          style: AppTextStyle.s12_w500(color: Colors.black),
        ),
      );
    } else {
      getIt<LoadingHelper>().dismissDialog();
    }
  }

  Future<void> handleUserPayment(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    var data = await firestore.collection("users").doc( uid).get();
    var parsedUser = UserModel.fromJson(data.data()!);
    log("data : \n${parsedUser.toJson().toString()}");
    if (parsedUser.isPayment == true) {
      if (parsedUser.paymentType == "week") {
        _handleWeekPayment(parsedUser, context);
      } else if (parsedUser.paymentType == "monthly") {
        _handleMonthPayment(parsedUser, context);
      } else if (parsedUser.paymentType == "yearly") {
        _handleYearPayment(parsedUser, context);
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Payment(),
      ));
    }
  }

  void _handleWeekPayment(UserModel user, BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    final DateTime date = user.paymentDate!.toDate();
    if (date.day == now.day - 3 ||
        date.isBefore(
          DateTime(
            now.year,
            now.month,
            now.day - 3,
          ),
        )) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Payment(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>  Home(deviceId: uid!,),
        ),
      );
    }
  }

  void _handleMonthPayment(UserModel user, BuildContext context)async {
    String ? uid = await GetDeviceId().deviceId;

    final DateTime date = user.paymentDate!.toDate();
    if (date.month == now.month - 1 ||
        date.isBefore(
          DateTime(
            now.year,
            now.month - 1,
            now.day,
          ),
        )) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Payment(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  Home(deviceId: uid!,),
      ));
    }
  }

  void _handleYearPayment(UserModel user, BuildContext context) async{
    String ? uid = await GetDeviceId().deviceId;
    final DateTime date = user.paymentDate!.toDate();
    if (date.year == now.year - 1 ||
        date.isBefore(
          DateTime(
            now.year - 1,
            now.month,
            now.day,
          ),
        )) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Payment(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  Home(deviceId: uid!,),
      ));
    }
  }
}
