part of 'cus_register_w_imports.dart';

class BuildCusRegister extends StatelessWidget {
  final RegisterController controller;

  const BuildCusRegister({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.signUp(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: Dimens.marginH50v20,
        padding: Dimens.marginH20v10,
        decoration: BoxDecoration(
            borderRadius: Dimens.borderRadius10PX,
            color: primaryColor
        ),
        child: Text(
          textAlign: TextAlign.center,
          tr("signUp",context).toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.font_sp14.sp
          ),
        ),
      ),
    );
  }
}
