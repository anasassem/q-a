// ignore_for_file: library_private_types_in_public_api

part of 'terms_imports.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  late TermsData controller;

  @override
  void initState() {
    controller = TermsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          tr("termsAndConditions", context),
          style: const AppTextStyle.s16_w700(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.dp20,
          vertical: Dimens.dp20,
        ),
        child: BlocBuilder<GenericBloc<String>, GenericState<String>>(
          bloc: tr("termsAndConditions", context) == "الشروط و الأحكام"
              ? controller.termsBlocAr
              : controller.termsBlocEn,
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  textAlign: TextAlign.start,
                  state.data,
                  style: const AppTextStyle.s16_w500(color: Colors.black54)
                      .copyWith(
                    height: 1.8,
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
