import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/const/AppConst.dart';
import 'package:watchandearn/global/global.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/otprevice.dart';
import 'package:watchandearn/screens/loginpage.dart';

class Otp extends StatefulWidget {
  static String verify = "";
  static String password1 = "";
  static String name = 'name';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Otpstate();
  }
}

class _Otpstate extends State<Otp> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordControll = TextEditingController();
  final TextEditingController confirmpasswordControll = TextEditingController();
  final TextEditingController referalControll = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  static String? countryDial;
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
  String referCode = "";
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
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
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
            Visibility(
                visible: isLoading,
                child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [CircularProgressIndicator()],
                  ),
                )),
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
        TextFormField(
          validator: (value) {
            isRequired(value!);
            return null;
          },
          keyboardType: TextInputType.text,
          onChanged: (val) {
            name = val;
          },
          decoration: InputDecoration(
            label: Text(
              "Name",
              style: TextStyle(color: Colors.black),
            ),
            prefixIcon: Icon(Icons.person),
            contentPadding: EdgeInsets.all(10),
            prefixIconColor: Colors.black,
            border: OutlineInputBorder(
                gapPadding: 12,
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: "Enter Name Here...",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        IntlPhoneField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          showCountryFlag: false,
          showDropdownIcon: true,
          initialValue: countryDial,
          validator: (val) => (val != null) ? 'Enter Phone First...' : null,
          onSaved: (val) {
            phone = countryDial! + phoneController.text;
            Otp.password1 = countryDial! + phoneController.text;
          },
          onCountryChanged: (country) {
            setState(() {
              countryDial = "+" + country.dialCode;
            });
          },
          decoration: InputDecoration(
            label: Text(
              "Phone",
              style: TextStyle(color: Colors.black),
            ),
            prefixIcon: Icon(Icons.phone),
            contentPadding: EdgeInsets.all(10),
            prefixIconColor: Colors.black,
            border: OutlineInputBorder(
                gapPadding: 12,
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: "Enter Phone Here...",
          ),
        ),
        TextField(
          keyboardType: TextInputType.text,
          onChanged: (val) {
            referCode = val;
          },
          decoration: InputDecoration(
            label: Text(
              "referal code",
              style: TextStyle(color: Colors.black),
            ),
            prefixIcon: Icon(Icons.code),
            contentPadding: EdgeInsets.all(10),
            prefixIconColor: Colors.black,
            border: OutlineInputBorder(
                gapPadding: 12,
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            hintText: "Enter referal code here...",
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        TextField(
          keyboardType: TextInputType.text,
          onChanged: (val) {
            password = val;
          },
          obscureText: hidetexr,
          decoration: InputDecoration(
            label: Text(
              "Password",
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
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Center(
          child: InkWell(
            onTap: () async {
              await CircularProgressIndicator();

              if (password != confirmPassword) {
                showSnackBarText(
                    "confirm password and password should be same");
              } else if (name.isEmpty) {
                showSnackBarText("Username is still empty!");
              } else if (phoneController.text.isEmpty) {
                showSnackBarText("phone number is still empty!");
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
              } else if (referCode == "123abc") {
                showSnackBarText("code is wrong");
              } else {
                refelCode = generateReferralCode(8);

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
                "Sign Up",
                style: TextStyle(
                    color: Color(0xffffc800),
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              )),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("Allready have an account? "),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              child: Container(
                child: Text(
                  "Log In.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  bool isLoading = false;

  bool currentstateLoding(bool value) {
    isLoading = value;
    print(isLoading);
    return isLoading;
  }

  void send() async {
    setState(() {
      currentstateLoding(true);
    });

    try {
      a = tryapi(
          name: name,
          phone: countryDial! + phoneController.text,
          referCode: referCode,
          password: password,
          refelCode: refelCode);
      var response = await http.post(
          Uri.parse("https://we.trionixtech.live:5600/user/userexists"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(a.tojson()));
      print(response.body);
      if (response.statusCode == 200) {
        var sharepref1 = await SharedPreferences.getInstance();
        sharepref1.setString(Otp.name, name);
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryDial! + phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            Otp.verify = verificationId;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => reciveotp(a)));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        setState(() {
          currentstateLoding(false);
        });
      } else {
        final errormessage = json.decode(response.body);
        final error = errormessage['message'];
        showSnackBar("Phone Number Is Already Exists ${error}");
        setState(() {
          currentstateLoding(false);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        currentstateLoding(false);
      });
    }
  }

  String generateReferralCode(int length) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZqwertyuioplkjhgfdsazxcvbnm';
    final random = Random();
    final codeBuffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      codeBuffer.write(chars[random.nextInt(chars.length)]);
    }
    return codeBuffer.toString();
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
