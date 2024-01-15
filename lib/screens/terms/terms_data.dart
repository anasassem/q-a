part of 'terms_imports.dart';

class TermsData {
  final GenericBloc<String> termsBloc = GenericBloc("");
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TermsData (){
    getTerms();
  }

  Future<void> getTerms ()async {
    var data = await firestore.collection("dashBoard").doc("dashBoard").get();
    var parsedData = DashBoardModel.fromJson(data.data()!);
    termsBloc.onUpdateData(parsedData.terms!);
  }
}