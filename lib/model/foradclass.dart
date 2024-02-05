class Ad {
  String AdUrl = "";
  String cliUrl = "";
  int gameId = 0;
  String Type = "";
  int second = 0;

  Ad(
      {this.AdUrl = "",
      this.cliUrl = "",
      this.Type = "",
      this.gameId = 0,
      this.second = 0});

  factory Ad.fromjson(Map<String, dynamic> jsondata) {
    return Ad(
      AdUrl: jsondata['AdUrl'],
      Type: jsondata['Type'],
      gameId: jsondata['gameId'],
      cliUrl: jsondata['cliUrl'],
      second: jsondata['second'],
    );
  }
}
