import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/datawithdrawl.dart';
import 'package:watchandearn/model/reason.dart';
import 'package:watchandearn/screens/loginpage.dart';

import '../model/registermodel.dart';

class withdrawl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _withdrawalState();
  }
}

class _withdrawalState extends State<withdrawl> {
  String Verifykey1 = "";
  String token = "";
  String Ip = "";
  String phone123 = "";
  bool isapiloading = true;
  withdrawldata re = withdrawldata();
  tryapi2 a = tryapi2();
  withdrawldata z = withdrawldata();
  var datastore = "data";
  var value1;
  reason a1 = reason();

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
              title: Text('withdrawal history',style: TextStyle(color: Colors.black),),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.amber,
            ),
            body: isapiloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
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
                                      "Amount",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      "upiId",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      "Status",
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
                                      "Reason",
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
                                      child: Center(
                                          child: Text(
                                              e.winDrawAmount.toString()))),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                      e.upiId.toString(),
                                      maxLines: 3,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                          child: Text(e.status.toString()))),
                                  Expanded(
                                      child: Text(
                                    e.reason.toString(),
                                    style: TextStyle(fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                                ),

                                    maxLines: 2,
                                  )),
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
    var Ip1 = sharepref1.getString(LoginPage.IPaddress);
    Verifykey1 = Verifykey != null ? Verifykey : "no value";
    token = token1 != null ? token1 : "no value";
    phone123 = phone != null ? phone : 'novalue';
    Ip = Ip1 != null ? Ip1 : "novalue";
    setState(() {
      print(Verifykey1);
      print(token);
      print(phone123);
      print(Ip);
      getsliderdata();
    });
  }

  Future<withdrawldata> getsliderdata() async {
    a = tryapi2(
      phone: phone123,
    );
    final responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/withdraw/find'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'verify': Verifykey1,
          'Ip': Ip
        },
        body: json.encode(a.tojson()));
    final data = await json.decode(responce.body);
    z = withdrawldata.fromjson(data);
    print(responce.body);
    setState(() {
      isapiloading = false;
    });
    return re;
  }
}
