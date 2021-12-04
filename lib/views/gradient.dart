import 'package:flutter/material.dart';

BoxDecoration GradientBackGround() {
  return BoxDecoration(
    // Box decoration takes a gradient
    gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      // Add one stop for each color. Stops should increase from 0 to 1

      colors: [
        // Colors are easy thanks to Flutter's Colors class.

        Colors.red.shade900,
   
    
        Colors.purple.shade900,
        Colors.purple.shade900,
        
        Colors.black,
      ],
    ),
  );
}
