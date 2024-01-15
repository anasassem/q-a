// ignore_for_file: use_build_context_synchronously

part of 'select_lang_imports.dart';

class SelectLang extends StatefulWidget {
  const SelectLang({super.key});

  @override
  State<SelectLang> createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {
  final SelectLangController controller = SelectLangController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text(
           tr("selectLang", context),
          style: AppTextStyle.s14_w600(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<GenericBloc<String>, GenericState<String>>(
        bloc: controller.langBloc,
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  tr("selectLanguage", context),
                  style: AppTextStyle.s24_w700(
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.changeLanguage(context, "ar"),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: state.data == "ar"
                            ? primaryColor
                            : Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  child: Text(
                    tr("arabic", context),
                    style:  AppTextStyle.s14_w600(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Gaps.vGap10,
              GestureDetector(
                onTap: () => controller.changeLanguage(context, "en"),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: state.data == "en"
                            ? primaryColor
                            : Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  child: Text(
                    tr("english", context),
                    style:  AppTextStyle.s14_w600(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async{
                  String? deviceId = await GetDeviceId().deviceId;
                  print(deviceId);
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(deviceId)
                      .set({
                    "is_payment": false,
                    "device_id": await GetDeviceId().deviceId,
                    "lang": context.read<LangCubit>().state.locale.languageCode,
                    "questions_count": 0
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Payment(),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    tr("confirm", context),
                    style:  AppTextStyle.s14_w600(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
/*  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.androidId; // Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // iOS identifierForVendor
      }
    } catch (e) {
      print("Error getting device ID: $e");
      return null;
    }
  }*/
}
