// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/count.dart';
import 'package:watchandearn/model/datafile.dart';
import 'package:watchandearn/model/datawithdrawl.dart';
import 'package:watchandearn/model/foradclass.dart';
import 'package:watchandearn/model/forimage.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/model/score.dart';
import 'package:watchandearn/screens/Admatre.dart';
import 'package:watchandearn/screens/Soccer.dart';
import 'package:watchandearn/screens/Tennis.dart';
import 'package:watchandearn/screens/cricketscreen.dart';
import 'package:watchandearn/screens/home_screen.dart';
import 'package:watchandearn/screens/loginpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class site extends StatefulWidget {
  static String count = 'count';
  Cricket1 q = Cricket1();
  Count z = Count();
  Cricket12 as = Cricket12();
  site(this.q, this.as);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sitestate();
  }
}

class _sitestate extends State<site> {
  WebViewController controller = WebViewController();
  IO.Socket? socket5;
  IO.Socket? socket6;
  List<Cricket1> listresults1 = [];
  List<Ad> listresults = [];
  bool isloading = true;
  var save;
  String savedmessage = "back1";
  Cricket12 w = Cricket12();
  Cricket1 w1 = Cricket1();
  List<String> Team1 = [];
  List<String> Team2 = [];
  List<String> Team3 = [];
  Datatest1 re = Datatest1();
  withdrawldata re1 = withdrawldata();
  Sendtime a = Sendtime();
  var b;
  String Verifykey1 = "";
  String token = "";
  String phone123 = "";
  bool isapiloading = true;
  withdrawldata z = withdrawldata();
  var datastore = "data";
  var value1;
  int gameId4 = 0;
  int gameId2 = 0;
  int gameId1 = 0;
  int count2 = 0;
  String Team = "";
  String Team12 = "";

  @override
  void initState() {
    getdatawith();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async {
          count2 == 4 ? Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Cricket()),
                  (route) => false) : count2 == 2 ?
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => tennis()),
                  (route) => false): Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Soccer()),
                  (route) => false);
          debugPrint("Will pop");
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            body: isapiloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      count2 == 4
                          ? InAppWebView(
                              initialUrlRequest: URLRequest(
                                  url: Uri.parse(
                                      "${re.setting[0].Tv}${gameId4}")),
                            )
                          : count2 == 2
                              ? InAppWebView(
                                  initialUrlRequest: URLRequest(
                                      url: Uri.parse(
                                          "${re.setting[0].Tv}${gameId2}")),
                                )
                              : InAppWebView(
                                  initialUrlRequest: URLRequest(
                                      url: Uri.parse(
                                          "${re.setting[0].Tv}${gameId1}")),
                                ),
                      isloading
                          ? Center(child: CircularProgressIndicator())
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                count2 == 4
                                                    ? Team
                                                    : count2 == 2
                                                        ? Team
                                                        : Team,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                child: Center(
                                                  child: Text(
                                                    w1.back1.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(5))),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                child: Center(
                                                  child: Text(
                                                    w1.lay1.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(5))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                count2 == 4
                                                    ? Team12
                                                    : count2 == 2
                                                        ? Team12
                                                        : Team12,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                child: Center(
                                                  child: Text(
                                                    w1.back2.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(5))),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                child: Center(
                                                  child: Text(
                                                    w1.lay2.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(5))),
                                          ],
                                        ),
                                        w1.back3 == 0 && w1.lay3 == 0
                                            ? Container()
                                            : Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "The Draw",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.all(5),
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.08,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.13,
                                                      child: Center(
                                                        child: Text(
                                                          w1.back3.toString(),
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blueAccent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5))),
                                                  Container(
                                                      margin: EdgeInsets.all(5),
                                                      child: Center(
                                                        child: Text(
                                                          w1.lay3.toString(),
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                      height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.08,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.13,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5))),
                                                ],
                                              ),
                                      ],
                                    ),
                            ],
                          )

                    ],
                  ),
          ),
        ));
  }

  void matchdata1() async {
    socket5 =
        IO.io("https://we.trionixtech.live:5600/${count2}", <String, dynamic>{
      "transports": ['websocket'],
      'autoConnect': false
    });

    socket5!.connect();
    socket5!.onConnect((_) {
      print("connect");
      socket5!.on("${count2}", (data) async {
        Orientation.landscape;
        for (int i = 0; i < data.length; i++) {
          if (count2 == 4) {
            if (gameId4 == data[i]["gameId"])  {
             //Team1 = w1.eventName.split('v');
              savename();
              w1 = Cricket1.fromjson(data[i]);
              if (this.mounted) {
                setState(() {
                  isapiloading = false;
                });
              }
            }
          } else if (count2 == 2) {
            if (gameId2 == data[i]["gameId"]) {
              //Team1 = w1.eventName.split('v');
              savename();
              w1 = Cricket1.fromjson(data[i]);
              if (this.mounted) {
                setState(() {
                  isapiloading = false;
                });
              }
            }
          } else {
            if (gameId1 == data[i]["gameId"]) {
              //Team1 = w1.eventName.split('v');
              savename();
              w1 = Cricket1.fromjson(data[i]);
              if (this.mounted) {
                setState(() {
                  isapiloading = false;
                });
              }
            }
          }
        }
      });
      return a;
    });
    print(socket5!.connected);
    socket5!.onDisconnect((_) => print('disconnect'));
    socket5!.on('fromServer', (_) => print(_));
  }

  void getdatawith() async {
    var sharepref1 = await SharedPreferences.getInstance();
    var phone = sharepref1.getString(LoginPage.userdataphone);
    var Verifykey = sharepref1.getString(LoginPage.userdataverify);
    var token1 = sharepref1.getString(LoginPage.userdatatoken);
    var game4 = sharepref1.getInt(Cricket.amaze);
    var game1 = sharepref1.getInt(Soccer.amaze2);
    var game2 = sharepref1.getInt(tennis.amaze1);
    var count1 = sharepref1.getInt(homepage.count);
    Verifykey1 = Verifykey != null ? Verifykey : "no value";
    token = token1 != null ? token1 : "no value";
    phone123 = phone != null ? phone : 'novalue';
    gameId4 = game4 != null ? game4 : 0;
    gameId2 = game2 != null ? game2 : 0;
    gameId1 = game1 != null ? game1 : 0;
    count2 = count1 != null ? count1 : 0;
    setState(() {
      getsliderdata1();
      matchdata1();
      socketforad();
      Timer.periodic(Duration(minutes: 1), (timer) {
        if (this.mounted) {
          setState(() {
            getsliderdata();
          });
        }
      });
    });
  }

  Future<withdrawldata> getsliderdata() async {
    a = Sendtime(Phone: phone123, Time: 1, Type: "Watch Earn");
     await http.post(
        Uri.parse('https://we.trionixtech.live:5600/earning/add'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'verify': Verifykey1
        },
        body: json.encode(a.tojson()));
    return re1;
  }

  Future<Datatest1> getsliderdata1() async {
    final responce = await http.get(
        Uri.parse('https://we.trionixtech.live:5600/appsetting/get'),
        headers: {'token': token, 'verify': Verifykey1});
    final Map<String, dynamic> data = jsonDecode(responce.body);
    print(responce.body);
    re = Datatest1.fromjson(data);
    return re;
  }

  void socketforad() {
    socket6 = IO.io("https://we.trionixtech.live:5600/k", <String, dynamic>{
      "transports": ['websocket'],
      'autoConnect': false
    });
    // print(socket5);
    socket6!.connect();
    socket6!.onConnect((_) {
      print("connect");
      socket6!.on("banner", (data) async {
        print(data);
        Orientation.landscape;
        for (int i = 0; i < data.length; i++) {
          if (count2 == 4) {
            if (gameId4 == data[i]["gameId"]) {
              listresults.add(Ad.fromjson(data[i]));
              if (listresults[0].Type == 'Video' ||
                  listresults[0].Type == "Image" ||
                  listresults[0].Type == "Ol") {
                if (this.mounted) {
                  setState(() {
                    socket5!.disconnect();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Ad1(listresults[0])),
                    );
                  });
                }
              }
            }
          } else if (count2 == 2) {
            if (gameId2 == data[i]["gameId"]) {
              listresults.add(Ad.fromjson(data[i]));
              if (listresults[0].Type == 'Video' ||
                  listresults[0].Type == "Image" ||
                  listresults[0].Type == "Ol") {
                if (this.mounted) {
                  setState(() {
                    socket5!.disconnect();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Ad1(listresults[0])),
                    );
                  });
                }
              }
            }
          } else {
            if (gameId1 == data[i]["gameId"]) {
              listresults.add(Ad.fromjson(data[i]));
              if (listresults[0].Type == 'Video' ||
                  listresults[0].Type == "Image" ||
                  listresults[0].Type == "Ol") {
                if (this.mounted) {
                  setState(() {
                    socket5!.disconnect();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Ad1(listresults[0])),
                    );
                  });
                }
              }
            }
          }
        }
      });
      return a;
    });
    print(socket6!.connected);
    socket6!.onDisconnect((_) => print('disconnect'));
    socket6!.on('fromServer', (_) => print(_));
  }
  void savename () async{
    Team1 =  await w1.eventName.split(' v ');
    Team = Team1[0];
    Team12 = Team1[1];
    if(this.mounted){
      setState(() {
        isloading = false;
      });
    }
  }
}
