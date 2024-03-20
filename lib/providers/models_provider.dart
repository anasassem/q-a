import 'package:testqa/models/models_model.dart';
import 'package:testqa/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-4-vision-preview";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels(BuildContext context) async {
    modelsList = await ApiService.getModels(context);
    return modelsList;
  }
}
