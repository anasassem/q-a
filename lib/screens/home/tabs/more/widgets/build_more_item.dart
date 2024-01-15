part of 'more_w_imports.dart';

class BuildMoreItem extends StatelessWidget {
  final String title ;
  final IconData icon ;
  final void Function() onTab ;
  const BuildMoreItem({super.key, required this.title, required this.icon, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimens.dp10),
        padding: const EdgeInsets.all(Dimens.dp5),
        decoration: CustomDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: primaryColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
