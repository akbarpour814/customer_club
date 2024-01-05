import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_page_route.dart';

class MyNavigator {
  static push(
    BuildContext context,
    Widget child,
  ) =>
      Navigator.push(
          context,
          CustomPageRoute(
              Directionality(textDirection: TextDirection.rtl, child: child)));

  static pushReplacement(
    BuildContext context,
    Widget child,
  ) =>
      Navigator.pushReplacement(
          context,
          CustomPageRoute(
              Directionality(textDirection: TextDirection.rtl, child: child)));

  static pushAndRemoveUntil(
    BuildContext context,
    Widget child, {
    bool? goFirst,
  }) =>
      Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(
              Directionality(textDirection: TextDirection.rtl, child: child)),
          (Route<dynamic> route) => (goFirst ?? false) ? route.isFirst : false);
}
