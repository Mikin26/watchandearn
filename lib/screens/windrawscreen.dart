import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/datawithdrawl.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/home_screen.dart';
import 'package:watchandearn/screens/loginpage.dart';

class Windraw extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WindrawState();
  }
}

class _WindrawState extends State<Windraw> {
  String Verifykey1 = "";
  String token = "";
  String phone123 = "";
  var balance;
  bool isapiloading = true;
  withdrawldata re = withdrawldata();
  tryapi23 a = tryapi23();
  tryapi234 a1 = tryapi234();
  withdrawldata z = withdrawldata();
  withdrawldata12 z1 = withdrawldata12();
  var datastore = "data";
  var value1;
  String upiId = "";
  String Amount = "";
  int finalAmount = 0;
  String Ip = "";
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

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
        title: Text('withdrawal',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),

        backgroundColor: Colors.amber,
      ),
      body: isapiloading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.02,
              ),
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
                            // ignore: unnecessary_null_comparison
                            "CurrentBalance : ${z1.result!.userBalance == null ? CircularProgressIndicator() : z1.result!.userBalance}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "upiId",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: controller,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          onChanged: (val) {
                            upiId = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Amount ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller1,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          onChanged: (val) {
                            Amount = val;
                            finalAmount = int.parse(Amount);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print(controller.text);

                        if (controller.text == "") {
                          showSnackBar("Please Enter UpiId");
                        } else if (controller1.text == "") {
                          showSnackBar("Amount is Required");
                        } else if (finalAmount > z1.result!.userBalance) {
                          showSnackBar("Insufficient Balance");
                        } else if (finalAmount == 0) {
                          showSnackBar("please Enter Amount");
                        }else if (finalAmount < 0) {
                          showSnackBar("Special Character is not allowed");
                        } else {
                          getsliderdata();
                          setState(()  {
                             forbalance();
                            controller.clear();
                            controller1.clear();
                          });
                          showSnackBar("Request send successfully");
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>homepage()));
                        }
                      },
                      child: Text("WithDraw"))
                ],
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
    var Ip2 = sharepref1.getString(LoginPage.IPaddress);
    setState(() {
      Verifykey1 = Verifykey != null ? Verifykey : "no value";
      token = token1 != null ? token1 : "no value";
      phone123 = phone != null ? phone : 'novalue';
      balance = getbalance!;
      Ip = Ip2!;
      forbalance();
    });
  }

  Future<withdrawldata> getsliderdata() async {
    a = tryapi23(
      userPhone: phone123,
      upiId: upiId,
      winDrawAmount: Amount,
      Ip: Ip,
    );
    final responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/withdraw/add'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'verify': Verifykey1
        },
        body: json.encode(a.tojson()));
    final data = await json.decode(responce.body);
    print(data);

    return re;
  }

  Future forbalance() async {
    a1 = tryapi234(
      phone: phone123,
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

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
