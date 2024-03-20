part of 'privacy_policy_imports.dart';
class PrivacyPolicyController{
  final GenericBloc<String> privacyPolicyBlocAr = GenericBloc("");
  final GenericBloc<String> privacyPolicyBlocEn = GenericBloc("");
  FirebaseFirestore firestore = FirebaseFirestore.instance ;

  PrivacyPolicyController(){
    getPrivacyPolicyAr();
    getPrivacyPolicyEn();
  }
  Future<void> getPrivacyPolicyAr ()async{
   var data = await firestore.collection("dashBoard").doc("dashBoard").get();
   var parsedData = DashBoardModel.fromJson(data.data()!);
   privacyPolicyBlocAr.onUpdateData(parsedData.privacyAr!);
  }
  Future<void> getPrivacyPolicyEn ()async{
   var data = await firestore.collection("dashBoard").doc("dashBoard").get();
   var parsedData = DashBoardModel.fromJson(data.data()!);
   privacyPolicyBlocEn.onUpdateData(parsedData.privacyEn!);
  }
}