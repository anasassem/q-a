part of 'privacy_policy_imports.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late PrivacyPolicyController controller;

  @override
  void initState() {
    controller = PrivacyPolicyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title:  Text( tr("privacyPolicy", context),
            style: const AppTextStyle.s16_w700(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp20,
          vertical: Dimens.dp20,
        ),
        child: BlocBuilder<GenericBloc<String>, GenericState<String>>(
          bloc: controller.privacyPolicyBloc,
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  state.data,
                  style: const AppTextStyle.s16_w500(
                    color: Colors.black54,
                  ).copyWith(
                    height: 1.6,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
