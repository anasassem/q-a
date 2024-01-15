class OcrModel {
  String? result;
  String? status;

  OcrModel({this.result, this.status});

  factory OcrModel.fromJson(Map<String, dynamic> json) {
    return OcrModel(
      result: json["result"],
      status: json["status"],
    );
  }
//
}
