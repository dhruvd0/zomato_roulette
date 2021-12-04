import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_roulette/cubit/getRestCubit.dart';
import 'package:zomato_roulette/views/gradient.dart';

class ShowRestaurants extends StatefulWidget {
  const ShowRestaurants({Key? key}) : super(key: key);

  @override
  _ShowRestaurantsState createState() => _ShowRestaurantsState();
}

class _ShowRestaurantsState extends State<ShowRestaurants> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GetRest>(context, listen: false).getRests();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width2 = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: GradientBackGround(),
        height: height,
        width: width2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "Bon Appétit !",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: Container(
                width: width2 / 2,
                child: BlocBuilder<GetRest, RestState>(
                  builder: (context, state) {
                    return ListView.builder(
                    
                        physics: BouncingScrollPhysics(),
                        itemCount: state.rests.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return Container(
                            width: width2 / 2,
                            color: Colors.white10,
                            margin: EdgeInsets.only(bottom: 20),
                         
                            child: Row(
                              children: [
                                Container(
                                  height: height / 5,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://i.insider.com/5e67f635235c1804132502e3?width=700&format=jpeg&auto=webp",
                                  ),
                                ),
                                SizedBox(
                                  width: width2 / 10,
                                ),
                                Text(
                                  state.rests[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: width2 / 10,
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
