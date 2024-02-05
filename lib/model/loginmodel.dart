class Userlogin {
  final String phone;
  final String password;

  Userlogin({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory Userlogin.fromJson(Map<String, dynamic> json) {
    return Userlogin(
      phone: json['phone'],
      password: json['password'],
    );
  }
}