class up {
  List<Result> result = [];
  up({
    this.result = const []
});
  factory up.fromjson(Map<String, dynamic>jsondata){
    return up(
      result: jsondata['result'] != null ? Result.list1(jsondata['result']) : [],
    );
  }
}
class Result {
  String AppVersion = "";
  String AppLink = "";
  Result({
    this.AppVersion = "",
    this.AppLink = ""
});
  factory Result.fromjson (Map<String, dynamic>jsondata){
    return Result(
      AppVersion: jsondata['AppVersion'],
      AppLink: jsondata['AppLink']
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