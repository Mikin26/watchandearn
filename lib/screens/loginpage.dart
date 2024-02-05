import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/model/reason.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/model/storeapidata.dart';
import 'package:watchandearn/screens/forgotpw.dart';
import 'package:watchandearn/screens/home_screen.dart';
import 'package:watchandearn/screens/splash_screen.dart';
import 'package:watchandearn/screens/signupPage.dart';

class LoginPage extends StatefulWidget {
  static String userdataphone = "phone";
  static String userdatahome = "refelcode";
  static String userdataverify = "verify";
  static String userdatatoken = "token";
  static String userdataname = "name";
  static var userbalance = "balance";
  static String IPaddress = "Ip";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordControll = TextEditingController();

  String phone = "";
  String password = "";
  static String? countryDial;
  bool passwordshow = true;
  tryapi verify = tryapi();
  bool hidepassword = true;
  reason r = reason();
  Userdata1 z = Userdata1();
  String Ip = "";

  // double? Height;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffc800),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Log In",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                IntlPhoneField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  showCountryFlag: false,
                  showDropdownIcon: true,
                  initialValue: countryDial,
                  validator: (val) =>
                      (val != null) ? 'Enter Phone First...' : null,
                  onSaved: (val) {
                    phone = phoneController.text;
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
                    contentPadding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.02,
                    ),
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                        gapPadding: 12,
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Phone Here...",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  obscureText: hidepassword,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.black),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidepassword = !hidepassword;
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => forgot()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (phoneController.text.isEmpty) {
                        showSnackBar("phone number is still empty!");
                      } else if (password.isEmpty) {
                        showSnackBar("password is still empty!");
                      } else if (isPasswordValid(password) == false) {
                        showSnackBar(
                            "Password must contain characters, digits, and a special character.");
                      } else if (password.length < 6) {
                        showSnackBar(
                            "password must be if atleast 6 characters long");
                      } else {
                        var sharepref = await SharedPreferences.getInstance();
                        sharepref.setBool(SplashScreen.Keylogin, true);

                        // sharepref.setString(userdatahome, "");
                        verifyUser();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Color(0xffffc800)),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account? "),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Otp()),
                            (route) => false);
                      },
                      child: Container(
                        child: Text(
                          "Sign Up.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
        ]),
      ),
    );
  }

  bool isLoading = false;

  bool currentstateLoding(bool value) {
    isLoading = value;
    print(isLoading);
    return isLoading;
  }

  Future<Userdata1> verifyUser() async {
    setState(() {
      currentstateLoding(true);
    });
    verify = tryapi(
      phone: countryDial! + phoneController.text,
      password: password,
    );
    var responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(verify.tojson()));
    final data = await json.decode(responce.body);
    print(responce.body);
    if (responce.statusCode == 200) {
      var sharepref1 = await SharedPreferences.getInstance();
      z = Userdata1.fromjson(data);
      sharepref1.setString(LoginPage.userdataphone, z.user!.phone);
      sharepref1.setString(LoginPage.userdataname, z.user!.name);
      sharepref1.setString(LoginPage.userdatahome, z.user!.refelCode);
      sharepref1.setInt(LoginPage.userbalance, z.user!.userBalance);
      sharepref1.setString(LoginPage.userdataverify, z.verify);
      sharepref1.setString(LoginPage.userdatatoken, z.token);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => homepage()),
          (route) => false);
      var responce1 = await http.get(
        Uri.parse('https://api.ipify.org'),
        headers: {'Content-Type': 'application/json'},
      );
      print(responce1.body);
      Ip = responce1.body;
      if (responce1.statusCode == 200) {
        r = reason(
            UserPhone: countryDial! + phoneController.text,
            Reason: 'Login',
            DeviceIp: Ip);
        var reason1 = await http.post(
            Uri.parse('https://we.trionixtech.live:5600/log/add'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(r.tojson()));
        sharepref1.setString(LoginPage.IPaddress, Ip);
        print(reason1.body);
      }
    } else {
      setState(() {
        currentstateLoding(false);
      });
      showSnackBar('User not registered');
      currentstateLoding(false);
    }

    return z;
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
  bool isPasswordValid(String password) {
    RegExp passwordPattern = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=])');

    return passwordPattern.hasMatch(password);
  }
}
