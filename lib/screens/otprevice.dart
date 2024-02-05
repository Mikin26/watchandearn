import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:watchandearn/model/reason.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/loginpage.dart';
import 'package:watchandearn/screens/signupPage.dart';

class reciveotp extends StatefulWidget {
  tryapi i = tryapi();

  reciveotp(this.i);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _reciveotpstate();
  }
}

class _reciveotpstate extends State<reciveotp> {
  Timer? timer;
  int start = 30;
  bool iscomplate = false;

  @override
  void initState() {
    // TODO: implement initState
    starttimer();
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  String code = "";
  reason r = reason();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffc800),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "We just sent a code to ",
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: widget.i.phone,
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: "\nEnter the code here and we can continue!",
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                pinAnimationType: PinAnimationType.fade,
                onChanged: (val) {
                  code = val;
                  print(code);
                  print(widget.i.refelCode);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0f1f41),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: StadiumBorder(),
                  ),
                  child: Text("submit"),
                  onPressed: () async {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: Otp.verify, smsCode: code);
                    await auth.signInWithCredential(credential);
                    // ignore: unnecessary_null_comparison
                    if (credential != null) {
                      print("Success");
                    } else {
                      showSnackBar('OTP is in valid');
                    }
                    var response = await http.post(
                        Uri.parse("https://we.trionixtech.live:5600/user/add"),
                        headers: {'Content-Type': 'application/json'},
                        body: json.encode(widget.i.tojson()));

                    print(response.body);
                    if (response.statusCode == 200) {
                      showSnackBar('User Successfully Registered');
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      r = reason(UserPhone: widget.i.phone, Reason: 'SignUp');

                      var reason1 = await http.post(
                          Uri.parse('https://we.trionixtech.live:5600/log/add'),
                          headers: {'Content-Type': 'application/json'},
                          body: json.encode(r.tojson()));
                      print(reason1.body);
                    } else {
                      showSnackBar('OTP is in valid');
                    }
                  }),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Didn't receive the code? ",
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                  iscomplate
                      ? WidgetSpan(
                          child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: widget.i.phone,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  Otp.verify = verificationId;
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                              setState(() {
                                start = 30;
                                starttimer();
                                iscomplate = false;
                              });
                            },
                            child: Container(
                              child: Text(
                                "Resend",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : TextSpan(
                          text: ("${start}"),
                          style: TextStyle(
                            color: Colors.black,
                          ))
                ],
              ),
            ),
          ],
        ),
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

  void starttimer() {
    const onesec = const Duration(seconds: 1);
    timer = new Timer.periodic(onesec, (Timer timer) {
      if (start == 0) {
        setState(() {
          iscomplate = true;
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
