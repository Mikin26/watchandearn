import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchandearn/screens/splash_screen.dart';
import 'package:watchandearn/screens/signupPage.dart';

class CustomPageView extends StatefulWidget {
  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final controller = PageController();
  static int val = 0;
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  PageView(
            controller: controller,
            onPageChanged: (index) {
              val = index;
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                  color: Color(0xffffc800),
                  name: 'Watch',
                  imgurl: 'assets/splash1.png',
                  subtitle:
                      'Enjoy watching live TV sports for free and watch faster then your TV'),
              buildPage(
                  color: Color(0xffffc800),
                  name: 'And',
                  imgurl: 'assets/splash4.png',
                  subtitle:
                      'When discarding your waste, find ways to recycle it instead of letting it go to landfill.'),
              buildPage(
                  color: Color(0xffffc800),
                  name: 'Earn',
                  imgurl: 'assets/splash3.png',
                  subtitle:
                      'If you have to acquire goods, try getting used ones or obtaining substitutes.'),
            ],
          ),

        bottomSheet: isLastPage
            ? Container(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.06),
                width: MediaQuery.of(context).size.width * 8,
                height: MediaQuery.of(context).size.height * 0.1,
                color: Color(0xffffc800),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01),
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    "Finish",
                    style: TextStyle(color: Color(0xffffc800)),
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setBool(SplashScreen.Keyskip, false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Otp()),
                        (route) => false);
                  },
                ))
            : Container(
                color: Color(0xffffc800),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
                height: MediaQuery.of(context).size.height*0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    val == 0
                        ? TextButton(
                            onPressed: () => controller.jumpToPage(2),
                            child: Text(
                              'SKIP',
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        : val == 1
                            ? Container(
                                //  height: MediaQuery.of(context).size.height*0.05,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  onPressed: () => controller.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                                  icon: Center(
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Color(0xffffc800),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black),
                      child: IconButton(
                        onPressed: () => controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                        icon: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xffffc800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  buildPage(
      {required Color color,
      required String name,
      required String imgurl,
      required String subtitle}) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
      color: color,
      child: Column(
        children: [
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.1,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Image.asset(
            imgurl,
            height: MediaQuery.of(context).size.height * 0.45,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.028),
              child: Text(
                subtitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.025),
              )),
        ],
      ),
    );
  }
}
