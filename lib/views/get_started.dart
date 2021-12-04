import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomato_roulette/views/enter_rest.dart';
import 'package:zomato_roulette/views/gradient.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    super.initState();
  }

  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    var width2 = MediaQuery.of(context).size.width;
    var height2 = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width2,
        height: height2,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            decoration: GradientBackGround()
          ),
          Positioned(
            top: height2 / 2 - 120,
            child: Text(
              "Zomato Roulette",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          Positioned(
            top: height2 / 2 - 70,
            child: Text(
              "Hungry? Cant Decide Where to Eat today?",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          
          Positioned(
            bottom: 100,
              child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (_) => SearchRest()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(25),
              child: Text(
                "Get Started",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),),
        ]),
      ),
    );
  }
}
