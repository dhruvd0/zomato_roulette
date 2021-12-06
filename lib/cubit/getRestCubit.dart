import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:web_scraper/web_scraper.dart';

class GetRest extends Cubit<RestState> {
  GetRest() : super(RestState(rests: [], enteredRest: "Pai Vihar")) {}
  List<String> names = [
    "Pai Vihar",
    " Stoned Monkey",
    "New Friends",
    "The Diner",
    "Atithi",
    "Shrusti Coffee"
  ];
  Future<void> getRestImgs() async {
    List<Restaurant> restWithImages = state.rests;
    for (int i = 0; i < restWithImages.length; i++) {
      restWithImages[i].imgURL = await getRestURL(restWithImages[i].name);
    }
    emit(state.copyWith(rests: restWithImages));
  }

  void loadDummy() {
    List<Restaurant> rests = List.generate(
      names.length,
      (index) => Restaurant(
        cuisine: "North Indian",
        name: names[index],
        cost: ((index + 1) * 100).toString(),
      ),
    );
    emit(state.copyWith(rests: rests));
  }

  Future<bool> getRests() async {
    String baseURL =
        "http://9e02-34-80-76-85.ngrok.io/recommend/${state.enteredRest}";
    try {
      Response response = await get(Uri.parse(baseURL));
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Restaurant Not found");
        return true;
      } else if (response.statusCode == 200) {
        Map body = jsonDecode(response.body);

        print(body);

        return true;
      } else {
        loadDummy();
        Fluttertoast.showToast(msg: "Error");
        return true;
      }
    } catch (e) {
      loadDummy();
      Fluttertoast.showToast(msg: "Error");

      return true;
    }
  }

  void changeRestName(String name) {
    emit(state.copyWith(enteredRest: name));
  }
}

class RestState {
  List<Restaurant> rests = [];
  String enteredRest = "Pai Vihar";
  RestState({
    required this.rests,
    required this.enteredRest,
  });

  RestState copyWith({
    List<Restaurant>? rests,
    String? enteredRest,
  }) {
    return RestState(
      rests: rests ?? this.rests,
      enteredRest: enteredRest ?? this.enteredRest,
    );
  }
}

class Restaurant {
  final String name;
  final String cost;
  final String cuisine;
  String? imgURL;
  Restaurant({
    required this.name,
    required this.cost,
    required this.cuisine,
    this.imgURL,
  });

  Restaurant copyWith({
    String? name,
    String? cost,
    String? cuisine,
    String? imgURL,
  }) {
    return Restaurant(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      cuisine: cuisine ?? this.cuisine,
      imgURL: imgURL ?? this.imgURL,
    );
  }
}

Future<String?> getRestURL(String query) async {
  assert(query.isNotEmpty);
  query += "Bangalore";

  final webScraper = WebScraper();
  log("web scrape init");
  var route =
      "https://www.google.com/search?tbm=isch&q=" + (query.replaceAll(" ", ""));
  await webScraper.loadFullURL(route).timeout(Duration(seconds: 5));
  log("web scraped loaded");
  var tag = webScraper.getElementAttribute("img", "src");
  return tag?.firstWhere((element) => (element?.contains("http") ?? false));
}
