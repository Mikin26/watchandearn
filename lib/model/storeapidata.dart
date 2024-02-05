class Userdata1 {
  User2? user;
  String token = "";
  String verify = "";

  Userdata1({this.user, this.token = "", this.verify = ""});

  factory Userdata1.fromjson(Map<String, dynamic> jsondata) {
    return Userdata1(
        verify: jsondata['verify'],
        token: jsondata['token'],
        user:
            jsondata['user'] != null ? User2.fromjson(jsondata['user']) : null);
  }
}

class User2 {
  String name = "";
  String phone = "";
  String referCode = "";
  String refelCode = "";
  var userBalance;

  User2({
    this.name = "",
    this.phone = "",
    this.refelCode = "",
    this.userBalance,
  });

  factory User2.fromjson(Map<String, dynamic> jsondata) {
    return User2(
        name: jsondata['name'],
        phone: jsondata['phone'],
        refelCode: jsondata['refelCode'],
        userBalance: jsondata['userBalance']);
  }

  Map<String, dynamic> tojson() {
    return {
      'userBalance': userBalance,
      'name': name,
      'phone': phone,
      'referCode': referCode,
      'refelCode': refelCode,
    };
  }
}
