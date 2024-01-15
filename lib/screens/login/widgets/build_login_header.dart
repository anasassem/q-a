part of 'login_widgets_imports.dart';
class BuildLoginHeader extends StatelessWidget {
  const BuildLoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.vGap128,
        Image.asset(
          Res.logo,
          scale: 3,
          height: Dimens.dp96,
        ),
      ],
    );
  }
}
