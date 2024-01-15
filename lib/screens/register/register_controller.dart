// ignore_for_file: use_build_context_synchronously

part of 'register_imports.dart';

class RegisterController {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController lang = TextEditingController();

  Future signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        _setRegister(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          CustomToast.showSimpleToast(msg: tr("emailISInUse", context));
          return;
        }
      }
    }
  }

  void _setRegister(BuildContext context) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    await FirebaseFirestore.instance
        .collection("users")
        .doc(credential.user!.uid)
        .set({
      "is_payment": false,
      "email": email.text,
      "device_id": await GetDeviceId().deviceId,
      "lang": context.read<LangCubit>().state.locale.languageCode,
    });
    if (credential.user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Payment(),
        ),
      );
    }
  }

  void _handleException(BuildContext context, dynamic e) {}
}
