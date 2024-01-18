import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension HttpResponseValidator on Response? {
  bool validate({bool withoutData = false, bool checkError = false}) {
    try {
      return (this != null &&
          this!.statusCode == 200 &&
          (withoutData || this!.data != null) &&
          ((!checkError ||
              (this!.data != null &&
                  (this!.data as Map<String, dynamic>)['status'] == true))));
    } catch (e) {
      return false;
    }
  }

  String get getErrorMessage {
    if (this != null && this!.data != null) {
      return (this!.data as Map<String, dynamic>)['message'] ??
          'خطا در برقراری ارتباط با سرور';
    }
    return 'خطا در برقراری ارتباط با سرور';
  }
}

extension NumberParsing on num {
  double w(BuildContext context) =>
      this * MediaQueryData.fromView(View.of(context)).size.width / 100;

  double h(BuildContext context) =>
      this * MediaQueryData.fromView(View.of(context)).size.height / 100;

  Widget wsb({Widget? child}) => SizedBox(
        width: toDouble(),
        child: child,
      );

  Widget hsb({Widget? child}) => SizedBox(
        height: toDouble(),
        child: child,
      );
  Widget whsb({Widget? child}) => SizedBox(
        width: toDouble(),
        height: toDouble(),
        child: child,
      );
}

extension StringUtil on String? {
  bool get isNotNullOrEmpty =>
      this != null && this != 'Null' && this != 'null' && this!.isNotEmpty;
}

extension StringExtension on String {
  bool get hasUpperCase => RegExp(r'[A-Z]+').hasMatch(this);
  bool get hasLowerCase => RegExp(r'[a-z]+').hasMatch(this);
  bool get hasNumber => RegExp(r'\d').hasMatch(this);
  bool get hasNonWords => RegExp(r'[\W_]+').hasMatch(this);
}
