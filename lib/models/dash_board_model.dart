class DashBoardModel {
  List<dynamic>? images;
  String? termsAr;
  String? termsEn;
  String? privacyAr;
  String? privacyEn;
  String? apiKey ;
  String? appLink ;

  DashBoardModel({this.images, this.termsAr,this.termsEn, this.privacyEn,this.privacyAr, this.apiKey, this.appLink});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    images =  json['imgs']??[];
    termsAr = json['terms_ar']??"";
    termsEn = json['terms_en']??"";
    privacyAr = json['privacy_ar']??"";
    privacyEn = json['privacy_en']??"";
    apiKey = json['api_key']??"";
    appLink = json['app_link']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgs'] = images;
    data['terms_ar'] = termsAr;
    data['terms_en'] = termsEn;
    data['privacy_ar'] = privacyAr;
    data['privacy_en'] = privacyEn;
    data['api_key'] = apiKey ;
    data['app_link'] = appLink ;
    return data;
  }
}