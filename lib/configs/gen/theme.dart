import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/configs/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

ThemeData myTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
    useMaterial3: true,
    fontFamily: FontFamily.dana,
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
            fontFamily: FontFamily.dana),
        hintStyle: const TextStyle(
            letterSpacing: 0,
            wordSpacing: 1,
            fontSize: 12,
            fontFamily: FontFamily.dana,
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
