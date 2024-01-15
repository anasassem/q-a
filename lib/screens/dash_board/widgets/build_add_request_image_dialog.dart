// ignore_for_file: use_build_context_synchronously

part of 'dash_board_w_imports.dart';

class BuildAddImageDialog extends StatelessWidget {
  final DashBoardController controller;

  const BuildAddImageDialog({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        vertical: Dimens.dp30,
        horizontal: Dimens.dp10,
      ).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimens.dp15.r,
        ),
      ),
      backgroundColor: Colors.white,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              await controller.getImageFromCamera(context);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.dp10,
                vertical: Dimens.dp30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                    size: 15,
                  ),
                  Gaps.vGap5,
                  Text(
                    tr("camera", context),
                    style: const AppTextStyle.s12_w400(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Gaps.hGap32,
          GestureDetector(
            onTap: () async {
              await controller.getRequestImages(context);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.dp10,
                vertical: Dimens.dp10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: Colors.black,
                    size: 15,
                  ),
                  Gaps.vGap5,
                  Text(
                    tr("gallary", context),
                    style: const AppTextStyle.s12_w400(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
