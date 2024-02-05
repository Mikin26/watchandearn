class Datatest {
  List<Result> result = [];

  Datatest({
    this.result = const [],
  });

  factory Datatest.fromjson(Map<String, dynamic> jsonData) {
    return Datatest(
      result:
          jsonData['result'] != null ? Result.list1(jsonData['result']) : [],
    );
  }
}

class Result {
  String Image_Url = "";
  String Url = "";

  Result({
    this.Image_Url = "",
    this.Url = "",
  });

  factory Result.fromjson(Map<String, dynamic> jsonData) {
    return Result(
      Image_Url: jsonData['Image_Url'],
      Url: jsonData['Url'],
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

class Datatest1 {
  List<setting1> setting = [];

  Datatest1({
    this.setting = const [],
  });

  factory Datatest1.fromjson(Map<String, dynamic> jsonData) {
    return Datatest1(
      setting: jsonData['setting'] != null
          ? setting1.list1(jsonData['setting'])
          : [],
    );
  }
}

class setting1 {
  String News = "";
  String Tv = "";

  setting1({this.News = "", this.Tv = ""});

  factory setting1.fromjson(Map<String, dynamic> jsonData) {
    return setting1(
      News: jsonData['News'],
      Tv : jsonData['Tv'],
    );
  }

  static List<setting1> list1(List result) {
    List<setting1> listresults = [];
    for (int i = 0; i < result.length; i++) {
      listresults.add(setting1.fromjson(result[i]));
    }
    return listresults;
  }
}
