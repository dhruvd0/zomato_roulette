import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRest extends StatefulWidget {
  const SearchRest({Key? key}) : super(key: key);

  @override
  State<SearchRest> createState() => _SearchRestState();
}

class _SearchRestState extends State<SearchRest> {
  @override
  void initState() {
    super.initState();
  }

  String restName = "Burger King";

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
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1

                colors: [
                  // Colors are easy thanks to Flutter's Colors class.

                  Colors.purple.shade800,
                  Colors.purple.shade800,
                  Colors.purple.shade900,
                  Colors.purple.shade900,
                  Colors.black,
                ],
              ),
            ),
          ),
          Positioned(
            top: height2 / 2 - 120,
            child: Text(
              "Name Any Restaurant",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          Positioned(
            top: height2 / 2 - 70,
            child: Text(
              "We will do the rest for you",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Positioned(
            bottom: 200,
            child: Container(
              height: 100,
              width: restName.length * 60 < 200 ? 200 : restName.length * 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(40),
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: restName,
                onChanged: (str) {
                  setState(() {
                    restName = str;
                  });
                },
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Positioned(
              bottom: 100,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(25),
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        ]),
      ),
    );
  }
}
