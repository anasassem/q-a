part of 'login_widgets_imports.dart';

class BuildLoginButton extends StatelessWidget {
  final LoginController controller;

  const BuildLoginButton({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.signIn(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: primaryColor
        ),
        child: Text(
          textAlign: TextAlign.center,
          tr("signIn", context),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}
