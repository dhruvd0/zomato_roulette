import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomato_roulette/cubit/getRestCubit.dart';
import 'package:zomato_roulette/views/gradient.dart';
import 'package:zomato_roulette/views/show_rest.dart';

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
    int textBoxLength = restName.length * 30;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width2,
        height: height2,
        decoration: GradientBackGround(),
        child: Stack(alignment: Alignment.center, children: [
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
              "We will do the rest for you :)",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Positioned(
            bottom: 200,
            child: BlocBuilder<GetRest, RestState>(
              builder: (context, state) {
                return Container(
                  width: textBoxLength < 200 ? 200 : textBoxLength.toDouble(),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: state.enteredRest,
                    onChanged: (str) {
                      BlocProvider.of<GetRest>(context, listen: false)
                          .changeRestName(str);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              },
            ),
          ),
          Positioned(
              bottom: 100,
              child: GestureDetector(
                onTap: () async {
                  bool success =
                      await BlocProvider.of<GetRest>(context, listen: false)
                          .getRests();

                  if (success) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ShowRestaurants(),
                      ),
                    );
                  } else {}
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Find similar restaurants",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
