// ignore_for_file: use_build_context_synchronously

part of 'login_widgets_imports.dart';

class BuildLoginForm extends StatelessWidget {
  final LoginController controller;

  const BuildLoginForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap50,
          GenericTextField(
            controller: controller.email,
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: Dimens.paddingAll10PX,
            enableBorderColor: Colors.transparent,
            margin: Dimens.paddingHorizontal15PX,
            fieldTypes: FieldTypes.normal,
            type: TextInputType.emailAddress,
            action: TextInputAction.next,
            validate: (value) => value!.validateEmail(),
            label: tr("email", context),
          ),
          Gaps.vGap20,
          GenericTextField(
              controller: controller.password,
              fillColor: Colors.grey.withOpacity(0.1),
              fieldTypes: FieldTypes.password,
              type: TextInputType.visiblePassword,
              action: TextInputAction.done,
              validate: (value) => value!.validateEmpty(),
              enableBorderColor: Colors.transparent,
              contentPadding: Dimens.paddingAll10PX,
              label: tr("password", context),
              margin: Dimens.paddingHorizontal15PX),
          BlocBuilder<GenericBloc<bool>, GenericState<bool>>(
            bloc: controller.rememberMeBloc,
            builder: (context, state) => Padding(
              padding: Dimens.paddingHorizontal15PX,
              child: CheckboxListTile(
                checkColor: primaryColor,
                activeColor: Colors.grey,
                value: state.data,
                onChanged: (value) async {
                  var emails = [];
                  var data = {
                    "email": controller.email.text,
                    "password": controller.password.text,
                  };
                  if (value == true) {
                    emails.add(data);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("users", json.encode(emails));
                  }
                  controller.rememberMeBloc.onUpdateData(!state.data);
                  print(emails);
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.only(left: 0, top: 0),
                title: Text(
                  tr("rememberMe", context),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
