import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class GetRest extends Cubit<RestState> {
  GetRest() : super(RestState(rests: [], enteredRest: "Burger King")) {}
 

  Future<bool> getRests() async {
     String baseURL = "https://jsonplaceholder.typicode.com/todos/1";
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
      return false;
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
  Restaurant({
    required this.name,
    required this.cost,
  });

  Restaurant copyWith({
    String? name,
    String? cost,
  }) {
    return Restaurant(
      name: name ?? this.name,
      cost: cost ?? this.cost,
    );
  }
}
