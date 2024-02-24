import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:watchandearn/model/count.dart';
import 'package:watchandearn/model/forimage.dart';
import 'package:watchandearn/model/getupdate.dart';
import 'package:watchandearn/model/loginmessage.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/model/storeapidata.dart';
import 'package:watchandearn/screens/home_screen.dart';
import 'package:watchandearn/screens/loginpage.dart';
import 'package:watchandearn/screens/skipscreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  static String Keylogin = "login";
  static String Keyskip = "skip";

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  tryapi a = tryapi();
  Userdata1 z = Userdata1();
  User2 q = User2();
  int current = 0;
  String verify = "";
  String token3 = "";
  String refel12 = "";
  String Verifykey1 = "bhargav";
  String token = "mikin";
  Datatest re = Datatest();
  Datatest1 re1 = Datatest1();
  List<Map<String, dynamic>> dataList = [];
  IO.Socket? socket;
  IO.Socket? socket1;
  bool isapiloading = true;
  Data test = Data();
  String savedmessage = "message";
  String savedmessage1 = "message1";
  String savedmessage2 = "message2";

  String defaultmessage = "On";
  String save = "";
  String save1 = "";
  String save3 = "";

  int? save2;
  String count1 = "count";
  Count data2 = Count();
  int total = 0;
  String appVersion = "";
  up update1 = up();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //checklogin();
    _getAppVersion();
    // TODO: implement initState
    super.initState();
  }
  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      getupdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Color(0xffffbe24),
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      ),
    );
  }

  void checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogedin = pref.getBool(SplashScreen.Keylogin);
    var isfirsttime = pref.getBool(SplashScreen.Keyskip);
    if (isfirsttime != null && !isfirsttime) {
      if (islogedin != null && islogedin) {         
        Future.delayed(Duration(seconds: 5)).then((value) {
          if (this.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => homepage(),
                ),
                (route) => false);
          }
        });
      } else {
        Future.delayed(Duration(seconds: 2)).then((value) {
          if (this.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
          }
        });
      }
    } else {
      Future.delayed(Duration(seconds: 2)).then((value) {
        if (this.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => CustomPageView(),
              ),
              (route) => false);
        }
      });
    }
  }
  void getupdate() async{
    checklogin();
    // final response =await http.get(Uri.parse("https://we.trionixtech.live:5600/appupdate/get")
    // );
    // //final Map<String, dynamic> data = jsonDecode(response.body);
    // //update1 = up.fromjson(data);
    // print(update1.result[0].AppVersion);
    // if (appVersion != update1.result[0].AppVersion){
    //   showDialog(
    //       context: context,
    //       barrierDismissible: false, // user must tap button!
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('Update!'),
    //           content: const SingleChildScrollView(
    //             child: ListBody(
    //               children: <Widget>[
    //                 Text('New Version is Available'),
    //                 Text('Please Update to New Version'),
    //               ],
    //             ),
    //           ),
    //           actions: <Widget>[
    //             TextButton(
    //               child: const Text('Update'),
    //               onPressed: () {
    //                 //launchUrl(Uri.parse(update1.result[0].AppLink));
    //                 checklogin();
    //               },
    //             ),
    //           ],
    //         );
    // }
    //   );

    // else {
    //   checklogin();
    // }
  }
  void showSnackBar(String text) {
    if (this.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }
  }
}
