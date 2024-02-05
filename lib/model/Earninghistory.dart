class Earninghis {
  List<Result> result = [];

  Earninghis({
    this.result = const [],
  });

  factory Earninghis.fromjson(Map<String, dynamic> jsonData) {
    return Earninghis(
      result:
      jsonData['result'] != null ? Result.list1(jsonData['result']) : [],
    );
  }
}

class Result {

  String Phone = "";
  int Earning = 0;
  String Type = "";

  Result({
    this.Phone = "",
    this.Earning = 0,
    this.Type = "",
  });

  factory Result.fromjson(Map<String, dynamic> jsonData) {
    return Result(
        Phone: jsonData['Phone'],
        Earning: jsonData['Earning'],
        Type: jsonData['Type']
    );
  }

  static List<Result> list1(List result) {
    List<Result> listresults = [];
    for (int i = 0; i < result.length; i++) {
      listresults.add(Result.fromjson(result[i]));
    }
    return listresults;
  }
}