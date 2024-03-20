// ignore_for_file: use_build_context_synchronously

part of 'more_w_imports.dart';

class BuildLangBottomSheet extends StatelessWidget {
  const BuildLangBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async{
              if(FirebaseAuth.instance.currentUser != null){
                var uid = await GetDeviceId().deviceId;
                FirebaseFirestore.instance.collection("users").doc(uid).update({"lang":"en"});
              }
              getIt<Utilities>().changeLanguage("en", context);
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child:  Text(
                textAlign: TextAlign.center,
                tr("en",context),
                style: AppTextStyle.s14_w600(color: Colors.black),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          InkWell(
            onTap: () async{
              if(FirebaseAuth.instance.currentUser != null){
                var uid = await GetDeviceId().deviceId;
                FirebaseFirestore.instance.collection("users").doc(uid).update({"lang":"ar"});
              }
              getIt<Utilities>().changeLanguage("ar", context);
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child:  Text(
                textAlign: TextAlign.center,
                tr("ar",context),
                style: AppTextStyle.s14_w600(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
