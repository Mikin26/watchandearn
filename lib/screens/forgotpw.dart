import 'dart:convert';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/otpforforgot.dart';
import 'package:watchandearn/screens/signupPage.dart';

class forgot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _forgotState();
  }
}

class _forgotState extends State<forgot> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordControll = TextEditingController();

  String phone = "";
  String password = "";
  static String? countryDial;
  bool passwordshow = true;
  tryapi verify = tryapi();
  bool hidepassword = true;

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  // double? Height;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffc800),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Forgot password",
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.05,
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
              ElevatedButton(
                  onPressed: () async {
                    if (phoneController.text.isEmpty) {
                      showSnackBar("phone number is still empty!");
                    } else {
                      verifyUser();
                      // var sharepref = await SharedPreferences.getInstance();
                      // sharepref.setBool(SplashScreen.Keylogin, true);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    'Verify Phone Number',
                    style: TextStyle(color: Color(0xffffc800)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void verifyUser() async {
    verify = tryapi(
      phone: countryDial! + phoneController.text,
    );
    var responce = await http.post(
        Uri.parse('https://we.trionixtech.live:5600/user/forget-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(verify.tojson()));
    print(responce.body);
    if (responce.statusCode == 200) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryDial! + phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          Otp.verify = verificationId;
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => forgototp(verify)),
              (route) => false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      showSnackBar('User not found');
    }
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
