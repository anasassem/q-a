// ignore_for_file: library_private_types_in_public_api

part of 'login_imports.dart';

class Login extends StatefulWidget {
  final List savedEmails;

  const Login({Key? key, required this.savedEmails}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = LoginController();

  @override
  void initState() {
    if(widget.savedEmails.isNotEmpty){
      Future.delayed(
        const Duration(seconds: 2),
            () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  widget.savedEmails.length,
                      (index) => GestureDetector(
                    onTap: () {
                      controller.email.text = widget.savedEmails[index]["email"];
                      controller.password.text = widget.savedEmails[index]["password"];
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.savedEmails[index]["email"],
                        style: const AppTextStyle.s12_w500(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAuthAppBar(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            const BuildLoginHeader(),
            BuildLoginForm(controller: controller),
            BuildLoginButton(controller: controller),
          ],
        ),
      ),
      bottomNavigationBar: const BuildRegisterBtn(),
    );
  }
}
