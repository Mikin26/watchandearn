import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:watchandearn/model/datafile.dart';
import 'package:watchandearn/model/score.dart';
import 'package:watchandearn/screens/home_screen.dart';
import 'package:watchandearn/screens/videoplayert.dart';

// ignore: must_be_immutable
class tennis extends StatefulWidget {
  static String amaze1 = "gameId1";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _tennisState();
  }
}

class _tennisState extends State<tennis> {
  IO.Socket? socket2;
  Crickettest w = Crickettest();
  List<Cricket1> listresults = [];
  bool isapiloading = true;
  IO.Socket? socket5;
  List<Cricket12> listresults1 = [];
  bool isloading = true;
  Cricket12 s = Cricket12();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    matchdata();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Watch And Earn",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xffffc800),
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              socket2!.disconnect();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => homepage()),
                  (route) => false);
            },
          ),
        ),
        body: isapiloading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    children: listresults.map((e) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                        ),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            e.Turnament,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var sharepref1 = await SharedPreferences.getInstance();
                          sharepref1.setInt(homepage.count, 2);
                          sharepref1.setInt(tennis.amaze1, e.gameId);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => site(e, s)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                          ),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: Center(
                            child: Text(
                              e.eventName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList()),
              ),
      ),
    );
  }

  void matchdata() {
    socket2 = IO.io("https://we.trionixtech.live:5600/2", <String, dynamic>{
      "transports": ['websocket'],
      'autoConnect': false
    });
    socket2!.connect();
    socket2!.onConnect((_) {
      print("connect");
        socket2!.on("2", (data) {
          print(data);
          socket2!.disconnect();
          for (int i = 0; i < data.length; i++) {
            listresults.add(Cricket1.fromjson(data[i]));

          }
          setState(() {
            isapiloading = false;
          });
          return listresults;
        });

    });
    print(socket2!.connected);
    socket2!.onDisconnect((_) => print('disconnect'));
    socket2!.on('fromServer', (_) => print(_));
  }
}
