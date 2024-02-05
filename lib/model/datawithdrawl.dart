class withdrawldata {
  List<Result> result = [];

  withdrawldata({
    this.result = const [],
  });

  factory withdrawldata.fromjson(Map<String, dynamic> jsonData) {
    return withdrawldata(
      result:
      jsonData['result'] != null ? Result.list1(jsonData['result']) : [],
    );
  }
}

class Result {
  var userPhone;

  var winDrawAmount;

  var upiId;

  var reason;

  var status;


  Result({
    this.userPhone,
    this.winDrawAmount,
    this.upiId,
    this.reason,
    this.status,
  });

  factory Result.fromjson(Map<String, dynamic> jsonData) {
    return Result(
      userPhone: jsonData['userPhone'],
      winDrawAmount: jsonData['winDrawAmount'],
      upiId: jsonData['upiId'],
      reason: jsonData['reason'],
      status: jsonData['status'],);
  }

  static List<Result> list1(List result) {
    List<Result> listresults = [];
    for (int i = 0; i < result.length; i++) {
      listresults.add(Result.fromjson(result[i]));
    }
    return listresults;
  }
}

class withdrawldata1 {
  List<Result1> result = [];

  withdrawldata1({
    this.result = const [],
  });

  factory withdrawldata1.fromjson(Map<String, dynamic> jsonData) {
    return withdrawldata1(
      result:
      jsonData['result'] != null ? Result1.list1(jsonData['result']) : [],
    );
  }
}

class Result1 {
  String refelCode = "";
  String referCode = "";
  String name = "";

  Result1({this.refelCode = "", this.referCode = "", this.name = ""});

  factory Result1.fromjson(Map<String, dynamic> jsonData) {
    return Result1(
        refelCode: jsonData['refelCode'],
        name: jsonData['name'],
        referCode: jsonData['referCode']);
  }

  static List<Result1> list1(List result) {
    List<Result1> listresults = [];
    for (int i = 0; i < result.length; i++) {
      listresults.add(Result1.fromjson(result[i]));
    }
    return listresults;
  }
}
