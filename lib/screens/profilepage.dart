import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/datawithdrawl.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/loginpage.dart';

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _profileState();
  }
}

class _profileState extends State<profile> {
  String Name = "";
  bool isapiloading = true;
  String phone = "";
  String refelcode = "";
  var balance;
  String Verifykey1 = "";
  String token = "";
  String phone123 = "";

  withdrawldata re = withdrawldata();
  tryapi23 a = tryapi23();
  tryapi234 a1 = tryapi234();
  withdrawldata z = withdrawldata();
  withdrawldata12 z1 = withdrawldata12();
  var datastore = "data";
  var value1;
  String upiId = "";
  String Amount = "";

  @override
  void initState() {
    getprofile();
    getdatawith();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Profile",
          style: GoogleFonts.poppins(
            //fontSize: MediaQuery.of(context).size.height * 0.1,
            color: Colors.amber,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.amber),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: isapiloading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Name,
                              style: TextStyle(fontSize: 17),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "RefelCode",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              refelcode,
                              style: TextStyle(fontSize: 17),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "Mobile",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              phone,
                              style: TextStyle(fontSize: 18),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            child: Text(
                              "User Balance ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(top: 10, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.height * 0.25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              z1.result!.userBalance.toString(),
                              style: TextStyle(fontSize: 17),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    ));
  }

  void getdatawith() async {
    var sharepref1 = await SharedPreferences.getInstance();
    var phone = sharepref1.getString(LoginPage.userdataphone);
    var Verifykey = sharepref1.getString(LoginPage.userdataverify);
    var token1 = sharepref1.getString(LoginPage.userdatatoken);
    var getbalance = sharepref1.getInt(LoginPage.userbalance);
    setState(() {
      Verifykey1 = Verifykey != null ? Verifykey : "no value";
      token = token1 != null ? token1 : "no value";
      phone123 = phone != null ? phone : 'novalue';
      balance = getbalance!;
      forbalance();
    });
  }

  void getprofile() async {
    var sharepref1 = await SharedPreferences.getInstance();
    var Name1 = sharepref1.getString(LoginPage.userdataname);
    var phonenumber = sharepref1.getString(LoginPage.userdataphone);
    var getrefelcode = sharepref1.getString(LoginPage.userdatahome);
    var getbalance = sharepref1.getInt(LoginPage.userbalance);

    setState(() {
      balance = getbalance;
      Name = Name1!;
      phone = phonenumber!;
      refelcode = getrefelcode!;
    });
  }

  void forbalance() async {
    a1 = tryapi234(
      phone: phone,
    );
    final responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/user/balance'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'verify': Verifykey1
        },
        body: json.encode(a1.tojson()));
    final data = await json.decode(responce.body);
    print(data);
    z1 = withdrawldata12.fromjson(data);
    setState(() {
      isapiloading = false;
    });
  }
}
