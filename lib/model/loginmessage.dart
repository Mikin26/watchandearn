class Data {
  String message = "";
  app? APP;

  Data({this.message = "", this.APP});

  factory Data.fromjson(Map<String, dynamic> jsondata) {
    return Data(
        message: jsondata['message'],
        APP: jsondata['APP'] != null ? app.fromjson(jsondata['APP']) : null);
  }
}

class app {
  String App_Maintenance = "";
  String App_Status = "";

  app({this.App_Maintenance = "",
    this.App_Status = "",
  });

  factory app.fromjson(Map<String, dynamic> jsondata) {
    return app(App_Maintenance: jsondata['App_Maintenance'],
      App_Status: jsondata['App_Status']
    );
  }
}
