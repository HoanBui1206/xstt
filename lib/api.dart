class APIModel {
  final Data data;

  APIModel({
    this.data,
  });

  factory APIModel.fromJson(Map<String, dynamic> json) {
    return APIModel(
      data: Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  final String urlHome;
  final String urlSignIn;
  final String urlSignUp;
  final String urlPromotion;
  final String welcome;
  final String urlSupport;
  final String logo;
  Data({
    this.urlHome,
    this.urlSignIn,
    this.urlSignUp,
    this.urlPromotion,
    this.welcome,
    this.urlSupport,
    this.logo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      urlHome: json['UrlHome'] as String,
      urlSignIn: json['UrlSignIn'] as String,
      urlSignUp: json['UrlSignUp'] as String,
      urlPromotion: json['UrlPromotion'] as String,
      welcome: json['Welcome'] as String,
      urlSupport: json['UrlSupport'] as String,
      logo: json['Logo'] as String,
    );
  }
}
