import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:watchandearn/global/global.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/loginpage.dart';

// ignore: must_be_immutable
class Newpw extends StatefulWidget {
  static String verify = "";
  tryapi t = tryapi();

  Newpw(this.t);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewpwState();
  }
}

class _NewpwState extends State<Newpw> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  int screenState = Global.status;
  bool passwordshow = true;
  bool confpassword = true;
  bool hidetexr = true;
  bool hidetext = true;
  Color blue = const Color(0xff8cccff);
  String? verify;
  String? token;
  String number = "";
  String sms = "";
  Userdata userdata = Userdata();
  String? fullnumber;
  String? verID;
  String phonenumber = "";
  String smscode = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = "";
  String phone = "";
  String refer = "";
  String password = "";
  String referal = "";
  String confirmPassword = "";
  String refelCode = "";
  tryapi a = tryapi();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffc800),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: signUpFormKey,
                child: SingleChildScrollView(
                  child: stateRegister(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Widget stateRegister() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.text,
          onChanged: (val) {
            password = val;
          },
          obscureText: hidetexr,
          decoration: InputDecoration(
            label: Text(
              "New Password",
              style: TextStyle(color: Colors.black),
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  hidetexr = !hidetexr;
                  (passwordshow == false)
                      ? passwordshow = true
                      : passwordshow = false;
                });
              },
              child: Icon((passwordshow == false)
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            contentPadding: EdgeInsets.all(10),
            prefixIconColor: Colors.black,
            border: OutlineInputBorder(
                gapPadding: 12,
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: "Enter password here...",
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        TextField(
          keyboardType: TextInputType.text,
          obscureText: hidetext,
          onChanged: (val) {
            confirmPassword = val;
          },
          decoration: InputDecoration(
            label: Text(
              "Confirm Password",
              style: TextStyle(color: Colors.black),
            ),
            prefixIcon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  hidetext = !hidetext;
                  (confpassword == false)
                      ? confpassword = true
                      : confpassword = false;
                });
              },
              child: Icon((confpassword == false)
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            contentPadding: EdgeInsets.all(10),
            prefixIconColor: Colors.black,
            border: OutlineInputBorder(
                gapPadding: 12,
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: "Enter Confirm Password here...",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Center(
          child: InkWell(
            onTap: () async {
              if (password != confirmPassword) {
                showSnackBarText(
                    "confirm password and password should be same");
              } else if (password.isEmpty) {
                showSnackBarText("password is still empty!");
              } else if (isPasswordValid(password) == false) {
                showSnackBarText(
                    "Password must contain characters, digits, and a special character.");
              } else if (password.length < 6) {
                showSnackBarText(
                    "password must be if atleast 6 characters long");
              } else if (confirmPassword.isEmpty) {
                showSnackBarText("confirmpasswordControll is still empty!");
              } else {
                send();
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "Submit",
                style: TextStyle(
                    color: Color(0xffffc800),
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              )),
            ),
          ),
        ),
      ],
    );
  }

  void send() async {
    try {
      a = tryapi(
        phone: widget.t.phone,
        password: password,
      );
      var response = await http.post(
          Uri.parse("https://we.trionixtech.live:5600/user/forget-password"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(a.tojson()));
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        final errormessage = json.decode(response.body);
        final error = errormessage['message'];
        showSnackBar("fail to sign up" + error);
      }
    } catch (e) {
      print(e);
    }
  }

  bool isPasswordValid(String password) {
    RegExp passwordPattern = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=])');

    return passwordPattern.hasMatch(password);
  }

  noInternet() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 2),
        content: Text("No Internet Connection available !"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
