import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:watchandearn/model/count.dart';
import 'package:watchandearn/model/datafile.dart';
import 'package:watchandearn/model/foradclass.dart';
import 'package:watchandearn/model/score.dart';
import 'package:watchandearn/screens/videoplayert.dart';

// ignore: must_be_immutable
class Ad1 extends StatefulWidget {
  Ad i = Ad();

  Ad1(this.i);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Adstate();
  }
}

class _Adstate extends State<Ad1> {
  late VideoPlayerController controller1;
  Timer? timer;
  bool iscomplate = false;
  Cricket1 q12 = Cricket1();
  Count z12 = Count();
  Cricket12 as12 = Cricket12();
  int Cricket12345 = 0;
  @override
  void initState() {
    controller1 = VideoPlayerController.networkUrl(Uri.parse(widget.i.AdUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          controller1.play();
        });
      });
    starttimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(child: SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: widget.i.Type == "Video"
                    ? InkWell(child: VideoPlayer(controller1),
                  onTap: (){
                      launchUrl(Uri.parse(widget.i.cliUrl));
                  },
                )
                    : widget.i.Type == "Image"
                    ? InkWell(child: Image.network(widget.i.AdUrl),
                  onTap: (){
                      launchUrl(Uri.parse(widget.i.cliUrl));
                  },
                )
                    : InkWell(
                      child: InAppWebView(
                  initialUrlRequest:
                  URLRequest(url: Uri.parse(widget.i.AdUrl),
                  ),
                ),
                  onTap: (){
                        launchUrl(Uri.parse(widget.i.cliUrl));
                  },
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iscomplate
                      ? InkWell(
                    onTap: () {},
                    child: Container(
                      child: IconButton(
                          icon: Icon(Icons.close,),
                          onPressed: () {
                            if(widget.i.second == 0){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> site(q12, as12)), (route) => false);
                                controller1.pause();
                            }
                          }),
                    ),
                  )
                      : Text(
                    "${widget.i.second}",
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          )),
    ),
        onWillPop: () async{
          //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Ad1(widget.i)), (route) => false);
          showSnackBar("you can not skip this Ad");
      return false;
    },
    );
  }

  void starttimer() {
    const onesec = const Duration(seconds: 1);
    timer = new Timer.periodic(onesec, (Timer timer) {
      if (widget.i.second == 0) {
        setState(() {
          iscomplate = true;
          timer.cancel();
        });
      } else {
        setState(() {
          widget.i.second--;
        });
      }
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
