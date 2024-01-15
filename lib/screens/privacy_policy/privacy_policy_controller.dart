part of 'privacy_policy_imports.dart';
class PrivacyPolicyController{
  final GenericBloc<String> privacyPolicyBloc = GenericBloc("");
  FirebaseFirestore firestore = FirebaseFirestore.instance ;

  PrivacyPolicyController(){
    getPrivacyPolicy();
  }
  Future<void> getPrivacyPolicy ()async{
   var data = await firestore.collection("dashBoard").doc("dashBoard").get();
   var parsedData = DashBoardModel.fromJson(data.data()!);
   privacyPolicyBloc.onUpdateData(parsedData.privacy!);
  }
}