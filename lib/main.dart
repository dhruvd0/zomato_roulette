import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zomato_roulette/cubit/getRestCubit.dart';

import 'package:zomato_roulette/views/get_started.dart';
import 'package:zomato_roulette/views/show_rest.dart';

void main() {
  runApp(
    MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: "Zomato Roulette",
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => GetRest())],
        child: MaterialApp(home: const GetStarted()),
      ),
    ),
  );
}
