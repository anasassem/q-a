part of 'home_main_imports.dart';

class HomeMainController {
  final GenericBloc<List<dynamic>> bannersBloc = GenericBloc([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  HomeMainController (BuildContext context){
    getBanners(context);
  }

  Future<void> getBanners(BuildContext context) async {
    var data = await firestore.collection("dashBoard").doc("dashBoard").get();
    var parsedData = DashBoardModel.fromJson(data.data()!);
    bannersBloc.onUpdateData(parsedData.images!);
  }
}
