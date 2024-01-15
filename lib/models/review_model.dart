class ReviewModel {
  String? id;
  double? rate;
  String? comment;
  String? email ;

  ReviewModel({
    this.rate,
    this.comment,
    this.email
  });

  ReviewModel.fromJson(Map<String, dynamic> json, String this.id) {
    rate = json['rate'];
    comment = json['comment'];
    email = json ['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['comment'] = comment;
    data['email'] = email ;
    return data;
  }
}
