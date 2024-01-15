class DashBoardModel {
  List<dynamic>? images;
  String? terms;
  String? privacy;
  String? apiKey ;
  String? appLink ;

  DashBoardModel({this.images, this.terms, this.privacy, this.apiKey, this.appLink});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    images =  json['imgs']??[];
    terms = json['terms']??"";
    privacy = json['privacy']??"";
    apiKey = json['api_key']??"";
    appLink = json['app_link']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgs'] = images;
    data['terms'] = terms;
    data['privacy'] = privacy;
    data['api_key'] = apiKey ;
    data['app_link'] = appLink ;
    return data;
  }
}