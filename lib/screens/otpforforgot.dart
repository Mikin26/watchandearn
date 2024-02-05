import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:watchandearn/model/registermodel.dart';
import 'package:watchandearn/screens/newpw.dart';

import 'signupPage.dart';

// ignore: must_be_immutable
class forgototp extends StatefulWidget {
  tryapi i = tryapi();

  forgototp(this.i);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _forgototpState();
  }
}

class _forgototpState extends State<forgototp> {
  Timer? timer;
  int start = 30;
  bool iscomplate = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SafeArea(
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
                        await checkotp();
                        // if(){
                        //   showSnackBar('User Successfully Registered');
                        //
                        //
                        // }
                        // else{
                        //
                        //
                        // }
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
                              codeSent: (String verificationId,
                                  int? resendToken) {
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

  Future checkotp() async {
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: Otp.verify, smsCode: code);
    await auth.signInWithCredential(credential);
    // ignore: unnecessary_null_comparison
    if (credential != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Newpw(widget.i)),
              (route) => false);
    } else {
      showSnackBar('OTP is in valid');
    }
  }

  //
  // void timer1() {
  //   Timer(Duration(seconds: 30), () {
  //     setState(() {});
  //   });
  // }

  void starttimer() {
    const onesec = const Duration(seconds: 1);
    timer = new Timer.periodic(onesec, (Timer timer) {
      if (start == 0) {
        setState(() {
          iscomplate = true;
          timer.cancel();
        });
      } else {
        if(this.mounted){
          setState(() {
            start--;
          });
        }
      }
    });
  }
}
