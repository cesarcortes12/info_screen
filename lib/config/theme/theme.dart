import 'package:flutter/material.dart';

const colorSeed = Color(0xFF27499b);
const scaffoldBackgroundColor = Color.fromARGB(255, 248, 247, 247);

class AppTheme {
  ThemeData getTheme() => ThemeData(
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(colorSeed))),
      useMaterial3: true,
      colorSchemeSeed: colorSeed,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: colorSeed,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: colorSeed,
      ));
}
