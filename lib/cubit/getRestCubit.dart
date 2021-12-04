import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

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

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Not found");
        return false;
      } else if (response.statusCode == 200) {
        Map body = jsonDecode(response.body);

        print(body);
        return true;
      } else {
        Fluttertoast.showToast(msg: response.reasonPhrase.toString());
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      loadDummy();
      return true;
    }
  }

  void changeRestName(String name) {
    emit(state.copyWith(enteredRest: name));
    getRests();
  }
}

class RestState {
  List<Restaurant> rests = [];
  String enteredRest = "Burger King";
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
  Restaurant({
    required this.name,
    required this.cost,
    required this.cuisine
  });

  

  Restaurant copyWith({
    String? name,
    String? cost,
    String? cuisine,
  }) {
    return Restaurant(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      cuisine: cuisine ?? this.cuisine,
    );
  }
}
