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
        rating: "4.0",
        cost: ((index + 1) * 100).toString(),
      ),
    );
    emit(state.copyWith(rests: rests));
  }

  Future<bool> getRests() async {
    String baseURL = "http://f93c-34-132-6-149.ngrok.io/";

    String page = "/recommend/${state.enteredRest}";
    try {
      Response response = await get(Uri.parse(baseURL + page));
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Restaurant Not found");
        return false;
      } else if (response.statusCode == 200) {
        Map body = jsonDecode(response.body);
        List<Restaurant> rests = [];
        body.keys.toList().forEach((element) {
          Restaurant restaurant = Restaurant(
            name: element,
            cost: body[element]["cost"].toString(),
            cuisine: body[element]["cuisines"].toString(),
            rating: body[element]["Mean Rating"].toString(),
          );
          rests.add(restaurant);
        });
        emit(state.copyWith(rests: rests));
        return true;
      } else {
        loadDummy();
        Fluttertoast.showToast(msg: response.reasonPhrase.toString());
        return false;
      }
    } catch (e) {
      loadDummy();
      Fluttertoast.showToast(msg: e.toString());

      return false;
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
  final String rating;
  String? imgURL;
  Restaurant({
    required this.name,
    required this.cost,
    required this.cuisine,
    required this.rating,
    this.imgURL,
  });

  Restaurant copyWith({
    String? name,
    String? cost,
    String? cuisine,
    String? rating,
    String? imgURL,
  }) {
    return Restaurant(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      cuisine: cuisine ?? this.cuisine,
      rating: rating ?? this.rating,
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
