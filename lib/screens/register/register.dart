part of 'register_imports.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            tr("signUp", context).toUpperCase(),
            style: const AppTextStyle.s24_w700(color: Colors.black),
          ),
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: ListView(
          padding: Dimens.paddingHorizontal10PX,
          children: [
            BuildRegisterForm(
              controller: controller,
            ),
          ],
        ),
        bottomNavigationBar: BuildCusRegister(
          controller: controller,
        ),
      ),
    );
  }
}
