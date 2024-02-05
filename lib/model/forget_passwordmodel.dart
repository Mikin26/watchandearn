class Forgetpassword {
  final String phone;
  final String password;
  final String confirmpassword;

  Forgetpassword({
    required this.phone,
    required this.password,
    this.confirmpassword = ""
  }
      );

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory Forgetpassword.fromJson(Map<String, dynamic> json) {
    return Forgetpassword( phone: json['phone'],
         password: json['password'],
        );
  }
}

