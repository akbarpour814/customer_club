import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/configs/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

ThemeData myTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.primaryColor),
    useMaterial3: true,
    fontFamily: FontFamily.estedad,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(300, 34)),
            maximumSize: MaterialStateProperty.all(const Size(300, 34)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor:
                MaterialStateProperty.all(ColorPalette.secondryColor),
            minimumSize: MaterialStateProperty.all(const Size(300, 34)))),
    inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        labelStyle: const TextStyle(
            letterSpacing: 0,
            wordSpacing: 1,
            color: Colors.black,
            fontFamily: FontFamily.estedad),
        hintStyle: const TextStyle(
            letterSpacing: 0,
            wordSpacing: 1,
            fontSize: 12,
            fontFamily: FontFamily.estedad,
            color: ColorPalette.grayColor),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: ColorPalette.grayColor2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.grayColor2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.grayColor2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.grayColor2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.grayColor2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorPalette.grayColor2)),
        errorStyle: const TextStyle(fontSize: 11),
        contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6)),
  );
}
