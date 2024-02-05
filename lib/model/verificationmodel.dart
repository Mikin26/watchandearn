class VerificationData {
  final String verify;
  final String token;

  VerificationData(this.verify, this.token);

  Map<String, dynamic> toJson() {
    return {
      'verify': verify,
      'token': token,
    };
  }

  factory VerificationData.fromJson(Map<String, dynamic> json) {
    return VerificationData(
      json['verify'],
      json['token'],
    );
  }
}