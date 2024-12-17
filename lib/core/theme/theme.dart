import 'package:flutter/material.dart';
import 'package:getx_task/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1));

  static final darkThemeMode = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: Pallete.whiteColor),
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          focusedBorder: _border(Pallete.blackColor),
          enabledBorder: _border(Pallete.borderColor)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Pallete.backgroundColor));
}
