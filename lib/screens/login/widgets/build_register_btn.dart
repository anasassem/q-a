part of 'login_widgets_imports.dart';

class BuildRegisterBtn extends StatelessWidget {
  const BuildRegisterBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Register(),));
      },
      child: Container(
        margin: Dimens.paddingAll20PX,
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  tr("youDontHaveAccount", context),
                  style: AppTextStyle.s14_w400(color: Colors.grey),
                ),
                Text(
                  tr("registerNow", context),
                  style: AppTextStyle.s16_w700(color:primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
