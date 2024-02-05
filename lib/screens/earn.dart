import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/datawithdrawl.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/loginpage.dart';

class earn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _earnState();
  }
}

class _earnState extends State<earn> {
  String Verifykey1 = "";
  String token = "";
  String phone123 = "";
  bool isapiloading = true;
  withdrawldata re = withdrawldata();
  tryapi23 a = tryapi23();
  withdrawldata1 z = withdrawldata1();
  var datastore = "data";
  var value1;
  String refelcode = '';

  @override
  void initState() {
    getdatawith();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Refer And Earn',
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),

              backgroundColor: Colors.amber,
            ),
            body: isapiloading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      "RefelCode",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      "Name",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                              children: z.result.map((e) {
                            return Container(

                              height:
                              MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Center(
                                              child:
                                                  Text(e.referCode.toString())))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          child: Center(
                                        child: Text(
                                          e.name.toString(),
                                          maxLines: 3,
                                        ),
                                      ))),
                                ],
                              ),
                            );
                          }).toList()),
                        ],
                      ),
                    ),
                  )));
  }

  void getdatawith() async {
    var sharepref1 = await SharedPreferences.getInstance();
    var phone = sharepref1.getString(LoginPage.userdataphone);
    var Verifykey = sharepref1.getString(LoginPage.userdataverify);
    var token1 = sharepref1.getString(LoginPage.userdatatoken);
    var getrefelcode = sharepref1.getString(LoginPage.userdatahome);

    setState(() {
      Verifykey1 = Verifykey != null ? Verifykey : "no value";
      token = token1 != null ? token1 : "no value";
      phone123 = phone != null ? phone : 'novalue';

      refelcode = getrefelcode!;

      print(Verifykey1);
      print(token);
      print(phone123);

      getsliderdata();
    });
  }

  Future<withdrawldata> getsliderdata() async {
    a = tryapi23(
      refelCode: refelcode,
    );
    final responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/user/refer/earning'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'verify': Verifykey1
        },
        body: json.encode(a.tojson()));
    final data = await json.decode(responce.body);
    z = withdrawldata1.fromjson(data);
    print(responce.body);
    setState(() {
      isapiloading = false;
    });
    return re;
  }
}
