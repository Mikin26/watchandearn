class reason {
  String UserPhone = "";
  String Reason = "";
  String DeviceIp = "";
  String DeviceModel = "";

  reason({this.UserPhone = "",
    this.Reason = "",
    this.DeviceIp = "",
    this.DeviceModel = ""});

  factory reason.fromjson(Map<String, dynamic> jsondata) {
    return reason(
      UserPhone: jsondata['UserPhone'],
      Reason: jsondata['Reason'],
      DeviceIp: jsondata['DeviceIp'],
      DeviceModel: jsondata['DeviceModel'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'UserPhone': UserPhone,
      'Reason': Reason,
      'DeviceIp': DeviceIp,
      'DeviceModel': DeviceModel
    };
  }
}
