class PrivacyPolicyModel {
  String? privacyPolicy;

  PrivacyPolicyModel({this.privacyPolicy});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacy_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['privacy_policy'] = privacyPolicy;
    return data;
  }
}