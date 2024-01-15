part of 'dash_board_w_imports.dart';

class BuildSendNotifyDialog extends StatelessWidget {
  final DashBoardController controller;

  final String deviceId;

  const BuildSendNotifyDialog(
      {super.key, required this.controller, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
              top: Dimens.dp20,
              right: Dimens.dp24,
              left: Dimens.dp24,
              bottom: Dimens.dp10)
          .r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimens.dp15.r,
        ),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GenericTextField(
            max: 7,
            controller: controller.notification,
            fieldTypes: FieldTypes.rich,
            focusBorderColor: Colors.transparent,
            type: TextInputType.text,
            fillColor: cardColor,
            enableBorderColor: Colors.transparent,
            action: TextInputAction.next,
            textColor: Colors.black,
            validate: (value) => value!.validateEmpty(),
            label: tr("typeYourMsg", context),
            margin: const EdgeInsets.only(bottom: 15),
          ),
          GestureDetector(
            onTap: () async => controller.sendNotification(
              deviceId,
              "",
              controller.notification.text,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(Dimens.dp10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.dp28,
                vertical: Dimens.dp10,
              ),
              child:  Text(
                 tr("send", context),
                style:  AppTextStyle.s14_w600(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
