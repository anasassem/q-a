part of 'login_widgets_imports.dart';

class BuildSignInWithGoogle extends StatelessWidget {
  final LoginController controller ;
  const BuildSignInWithGoogle({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(tr("signInWithGoogle", context) ,style:  AppTextStyle.s14_w600(color: Colors.black)),
          Gaps.hGap10,
          Image.asset(Res.google, height: Dimens.dp20.h, width: Dimens.dp20.w,)
        ],
      ),
    );
  }
}
