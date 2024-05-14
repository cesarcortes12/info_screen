import 'package:flutter/material.dart';

const colorSeed = Color(0xFF27499b);
const scaffoldBackgroundColor = Color.fromARGB(255, 248, 247, 247);

class AppTheme {
  //static Color getColorSchemeSeed() {
  //return colorSeed;
  //}

  ThemeData getTheme() => ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(colorSeed))),

      ///* General
      useMaterial3: true,
      colorSchemeSeed: colorSeed,

      ///* Scaffold Background Color
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      ///* CustomAppBar()
      appBarTheme: AppBarTheme(
        //color: scaffoldBackgroundColor,
        backgroundColor: colorSeed,

        iconTheme: IconThemeData(
          color: Colors.white, // Cambia el color del ícono de hamburguesa aquí
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        //color: scaffoldBackgroundColor,
        backgroundColor: colorSeed,
      ));
}
