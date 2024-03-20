part of 'terms_imports.dart';

class TermsData {
  final GenericBloc<String> termsBlocAr = GenericBloc("");
  final GenericBloc<String> termsBlocEn = GenericBloc("");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TermsData (){
    getTermsAr();
    getTermsEn();
  }

  Future<void> getTermsAr ()async {
    var data = await firestore.collection("dashBoard").doc("dashBoard").get();
    var parsedData = DashBoardModel.fromJson(data.data()!);
    termsBlocAr.onUpdateData(parsedData.termsAr!);
  }

  Future<void> getTermsEn ()async {
    var data = await firestore.collection("dashBoard").doc("dashBoard").get();
    var parsedData = DashBoardModel.fromJson(data.data()!);
    termsBlocEn.onUpdateData(parsedData.termsEn!);
  }
}