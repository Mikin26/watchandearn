class Userdata {
  final String name;
  final String phone;
  final String referCode;
  final String password;
  final String confirmpassword;
  final String refelCode;

  Userdata(
      {this.name = '',
      this.phone = '',
      this.referCode = '',
      this.password = '',
      this.refelCode = "",
      this.confirmpassword = ""});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'referCode': referCode,
      'password': password,
      'refelCode': refelCode,
    };
  }

  factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(
        name: json['name'],
        phone: json['phone'],
        referCode: json['referCode'],
        password: json['password'],
        refelCode: json['refelCode']);
  }
}

class tryapi {
  String name = "";
  String phone = "";
  String referCode = "";
  String refelCode = "";
  String password = "";
  String confirmPassword = "";

  tryapi({
    this.name = "",
    this.phone = "",
    this.referCode = "",
    this.refelCode = "",
    this.password = "",
    this.confirmPassword = "",
  });

  factory tryapi.fromjson(Map<String, dynamic> jsondata) {
    return tryapi(
      name: jsondata['name'],
      phone: jsondata['phone'],
      referCode: jsondata['referCode'],
      refelCode: jsondata['refelCode'],
      password: jsondata['password'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'phone': phone,
      'referCode': referCode,
      'refelCode': refelCode,
      'password': password,
    };
  }
}

class tryapi2 {
  String name = "";
  String phone = "";
  String referCode = "";
  String refelCode = "";
  String password = "";
  String upiId = "";
  String Amount = "";
  int userBalance = 0;
  String confirmPassword = "";
  int Time = 1;
  String Type = "";
  int Earning = 0;

  tryapi2(
      {this.name = "",
      this.phone = "",
      this.Type = "",
      this.Earning = 0,
      this.userBalance = 0,
      this.referCode = "",
      this.refelCode = "",
      this.password = "",
      this.Time = 1,
      this.confirmPassword = "",
      this.Amount = "",
      this.upiId = ""});

  factory tryapi2.fromjson(Map<String, dynamic> jsondata) {
    return tryapi2(
        phone: jsondata['phone'],
        Earning: jsondata['Earning'],
        Type: jsondata['Type']);
  }

  Map<String, dynamic> tojson() {
    return {
      'phone': phone,
      'Time': Time,
      'Type': Type,
    };
  }
}

class tryapi23 {
  String name = "";
  String userPhone = "";
  String referCode = "";
  String refelCode = "";
  String password = "";
  String upiId = "";
  String winDrawAmount = "";
  String confirmPassword = "";
  String Ip = "";

  tryapi23(
      {this.name = "",
      this.userPhone = "",
      this.referCode = "",
      this.refelCode = "",
      this.password = "",
      this.Ip = "",
      this.confirmPassword = "",
      this.winDrawAmount = "",
      this.upiId = ""});

  factory tryapi23.fromjson(Map<String, dynamic> jsondata) {
    return tryapi23(
        userPhone: jsondata['userPhone'],
        upiId: jsondata['upiId'],
        winDrawAmount: jsondata['winDrawAmount']);
  }

  Map<String, dynamic> tojson() {
    return {
      'userPhone': userPhone,
      'upiId': upiId,
      'winDrawAmount': winDrawAmount,
      'refelCode': refelCode,
      'Ip': Ip,
    };
  }
}

class tryapi234 {
  String phone = "";

  tryapi234({
    this.phone = "",
  });

  factory tryapi234.fromjson(Map<String, dynamic> jsondata) {
    return tryapi234();
  }

  Map<String, dynamic> tojson() {
    return {
      'phone': phone,
    };
  }
}

class withdrawldata12 {
  Result1? result;

  withdrawldata12({
    this.result,
  });

  factory withdrawldata12.fromjson(Map<String, dynamic> jsonData) {
    return withdrawldata12(
      result: jsonData['result'] != null
          ? Result1.fromjson(jsonData['result'])
          : null,
    );
  }
}

class Result1 {
  int userBalance = 0;

  Result1({this.userBalance = 0});

  factory Result1.fromjson(Map<String, dynamic> jsonData) {
    return Result1(userBalance: jsonData['userBalance']);
  }
}

class Sendtime {
  String Phone = "";
  int Time = 1;
  String Type = "";

  Sendtime({
    this.Phone = "",
    this.Type = "",
    this.Time = 1,
  });

  factory Sendtime.fromjson(Map<String, dynamic> jsondata) {
    return Sendtime(Phone: jsondata['phone']);
  }

  Map<String, dynamic> tojson() {
    return {
      'Phone': Phone,
      'Time': Time,
      'Type': Type,
    };
  }
}
