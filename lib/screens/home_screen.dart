import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:watchandearn/model/checkupdate.dart';
import 'package:watchandearn/model/forimage.dart';
import 'package:watchandearn/model/loginmessage.dart';
import 'package:watchandearn/screens/Soccer.dart';
import 'package:watchandearn/screens/Tennis.dart';
import 'package:watchandearn/screens/cricketscreen.dart';
import 'package:watchandearn/screens/earn.dart';
import 'package:watchandearn/screens/earninghistory.dart';
import 'package:watchandearn/screens/loginpage.dart';
import 'package:watchandearn/screens/profilepage.dart';
import 'package:watchandearn/screens/splash_screen.dart';
import 'package:watchandearn/screens/windrawscreen.dart';
import 'package:watchandearn/screens/withdrawl.dart';
import '../model/count.dart';
import 'package:url_launcher/url_launcher.dart';

class homepage extends StatefulWidget {
  static String count = "count";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homepageState();
  }
}

class _homepageState extends State<homepage> {
  int current = 0;
  String verify = "";
  String token3 = "";
  String refel12 = "";
  String Verifykey1 = "";
  String token = "";
  Datatest re = Datatest();
  Datatest1 re1 = Datatest1();
  update asd = update();
  List<Map<String, dynamic>> dataList = [];
  IO.Socket? socket;
  IO.Socket? socket1;
  bool isapiloading = true;
  Data test = Data();
  String savedmessage = "message";
  String savedmessage1 = "On";
  String defaultmessage = "Authentication Successful";
  String defaultmessage1 = "On";
  String defaultmessage2 = "Close";
  String defaultmessage3 = "User Has Been Blocked From Admin Side";
  String save = "";
  String save1 = "";
  int? save2;
  String savedmessage3 = "message1";
  String savedmessage2 = "message2";
  String count1 = "count";
  Count data2 = Count();
  int total = 0;
  String save3 = '';
  String appVersion = "";
  @override
  void initState() {
    getvalue();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Socketforlogin();
    Socketdata();


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        drawer: Drawer(
            backgroundColor: Color(0xffffc800),
            child: ListView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              children: [
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => homepage()),
                        (route) => false);
                  },
                ),
                ListTile(
                  title: const Text('Withdrawal'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Windraw()));
                  },
                ),
                ListTile(
                  title: const Text('Earning History'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Earing()));
                  },
                ),
                ListTile(
                  title: const Text('Withdrawal History'),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => withdrawl()));
                  },
                ),
                ListTile(
                  title: const Text('Refer And Earn'),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => earn()));
                  },
                ),
              ],
            )),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Watch And Earn",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffffc800),
          actions: [
            IconButton(
                onPressed: () async {
                  socket!.disconnect();
                  socket1!.disconnect();
                  var sharepref5 = await SharedPreferences.getInstance();
                  sharepref5.setBool(SplashScreen.Keylogin, false);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                )),
            IconButton(
                onPressed: () async {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => profile()));
                },
                icon: Icon(
                  CupertinoIcons.person,
                )),
          ],
        ),
        body: isapiloading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView(
                      children: [
                        CarouselSlider(
                          items: re.result.map((e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  launchUrl(Uri.parse(
                                      "https://www.skyfair.vip/exchange/mobile/member/index.jsp"));
                                });
                                print(e.Url);
                              },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Image.network(
                                  e.Image_Url,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.2,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            // enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // enlargeCenterPage: true,
                            // enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                    child: Icon(Icons.mic))),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                                // width: double.infinity,
                                child: Marquee(
                                  text: re1.setting[0].News,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontWeight: FontWeight.bold),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 10.0,
                                  velocity: 100.0,

                                  startPadding: 10.0,

                                  accelerationCurve: Curves.linear,
                                  // decelerationDuration: Duration(milliseconds: 1000),
                                  decelerationCurve: Curves.easeOut,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          InkWell(
                            onTap: () async {
                              var sharepref1 =
                                  await SharedPreferences.getInstance();
                              sharepref1.setInt(homepage.count, 4);
                              data2.cricket == 0
                                  ? showSnackBar("Match is not Available")
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Cricket()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.04,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cricket',
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    data2.cricket.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/velki-sport-cricket.webp',
                                      )),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          InkWell(
                            onTap: () {
                              data2.soccer == 0
                                  ? showSnackBar("Match is not Available")
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Soccer()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.04,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Soccer',
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    data2.soccer.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/velki-sport-soccer.webp',
                                      )),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          InkWell(
                            onTap: () {
                              data2.tennis == 0
                                  ? showSnackBar("Match is not Available")
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => tennis()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.04,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tennis',
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    data2.tennis.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/velki-sport-tennis.webp',
                                      )),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void getvalue() async {
    var sharepref1 = await SharedPreferences.getInstance();
    var getrefelcode = sharepref1.getString(LoginPage.userdatahome);
    var Verifykey = sharepref1.getString(LoginPage.userdataverify);
    var token1 = sharepref1.getString(LoginPage.userdatatoken);
    refel12 = getrefelcode != null ? getrefelcode : "no value";
    Verifykey1 = Verifykey != null ? Verifykey : "no value";
    token = token1 != null ? token1 : "no value";
    setState(() {
      print(Verifykey1);
      print(token);
      getsliderdata();
    });
    dataList.add({'token': token, 'verify': Verifykey1});
  }

  Future<Datatest> getsliderdata() async {
    final responce = await http.get(
        Uri.parse('https://we.trionixtech.live:5600/slider/get'),
        headers: {'token': token, 'verify': Verifykey1});
    final Map<String, dynamic> data = jsonDecode(responce.body);
    print(responce.body);
    re = Datatest.fromjson(data);
    setState(() {
      getsliderdata1();
    });
    return re;
  }

  Future<Datatest1> getsliderdata1() async {
    final responce = await http.get(
        Uri.parse('https://we.trionixtech.live:5600/appsetting/get'),
        headers: {'token': token, 'verify': Verifykey1});
    final Map<String, dynamic> data = jsonDecode(responce.body);
    print(responce.body);
    re1 = Datatest1.fromjson(data);
    setState(() {
      isapiloading = false;
    });
    return re1;
  }

  void Socketdata() {
    socket1 =
        IO.io('https://we.trionixtech.live:5600/playcounts', <String, dynamic>{
      "transports": ['websocket'],
      'autoConnect': false
    });
    socket1!.connect();
    socket1!.onConnect((_) {
      print("connect");
      Timer a1 = Timer.periodic(Duration(seconds: 1), (value) {
        socket1!.on('count', (data) async {
          final Map<String, dynamic> count2 = data;
          data2 = Count.fromjson(count2);
          if (this.mounted) {
            setState(() {});
          }
        });
      });
      return a1;
    });
    socket1!.onDisconnect((_) => print('disconnect'));
    socket1!.on('fromServer', (_) => print(_));
  }

  void Socketforlogin() {
    socket = IO.io('https://we.trionixtech.live:5600/auth', <String, dynamic>{
      "transports": ['websocket'],
      'autoConnect': false
    });
    socket!.connect();
    socket!.onConnect((_) {
      print("connect");
      Timer a = Timer.periodic(Duration(seconds: 5), (value) {
        socket!.emit('auth', dataList);
      });
      return a;
    });
    print(socket!.connected);
    socket!.on('authResponse', (data) async {
      final Map<String, dynamic> savemessage = data;
      test = Data.fromjson(savemessage);
      var sharepref5 = await SharedPreferences.getInstance();
      sharepref5.setString(savedmessage, test.APP!.App_Maintenance);
      sharepref5.setString(savedmessage1, test.message);
      sharepref5.setString(savedmessage2, test.APP!.App_Status);
      var savedvalue = sharepref5.getString(savedmessage1);
      var savedvalue1 = sharepref5.getString(savedmessage);
      var savedvalue2 = sharepref5.getString(savedmessage2);
      save = savedvalue1 != null ? savedvalue1 : "no value";
      save1 = savedvalue != null ? savedvalue : "no value";
      save3 = savedvalue2 != null ? savedvalue2 : "no value";

      if (save == "Off") {
        if (save3 == "Open") {
          if (save1 != "User Has Been Blocked From Admin Side") {
            if (defaultmessage == save1) {
            } else {
              var sharepref5 = await SharedPreferences.getInstance();
              sharepref5.setBool(SplashScreen.Keylogin, false);
              socket!.disconnect();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
              showSnackBar("Account Login in Another Device");
            }
          } else {
            var sharepref5 = await SharedPreferences.getInstance();
            sharepref5.setBool(SplashScreen.Keylogin, false);
            socket!.disconnect();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false);
            showSnackBar("User is blocked by Admin");
          }
        } else {
          var sharepref5 = await SharedPreferences.getInstance();
          sharepref5.setBool(SplashScreen.Keylogin, false);
          socket!.disconnect();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
          showSnackBar("App is Closed");
        }
      } else {
        var sharepref5 = await SharedPreferences.getInstance();
        sharepref5.setBool(SplashScreen.Keylogin, false);
        socket!.disconnect();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        showSnackBar("App is in underMaintenance");
      }
    });
    socket!.onDisconnect((_) => print('disconnect'));
    socket!.on('fromServer', (_) => print(_));
  }
  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
