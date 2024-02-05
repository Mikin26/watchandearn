class Crickettest {
  List<Cricket1> result1 = [];

  Crickettest({
    this.result1 = const [],
  });
}

class Cricket1 {
  String Turnament = "";
  String eventName = "";
  int gameId = 0;
  var back1;

  var lay1;

  var back2;

  var lay2;

  var lay3;
  var back3;
  int Cricket = 4;
  int Soccer = 1;
  int Tennis = 2;

  Cricket1(
      {this.Turnament = "",
      this.eventName = "",
      this.gameId = 0,
      this.back1,
      this.lay1,
      this.back2,
      this.lay2,
      this.back3,
      this.lay3});

  factory Cricket1.fromjson(Map<String, dynamic> jsondata) {
    return Cricket1(
        Turnament: jsondata['Turnament'] != null
            ? jsondata['Turnament']
            : "Watch and Earn",
        eventName: jsondata['eventName'] != null
            ? jsondata['eventName']
            : "Watch and Earn",
        gameId: jsondata['gameId'],
        lay1: jsondata['lay1'],
        back1: jsondata['back1'],
        lay2: jsondata['lay2'],
        back2: jsondata['back2'],
        back3: jsondata['back3'],
        lay3: jsondata['lay3']);
  }

}
