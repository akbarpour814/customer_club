import 'package:animations/animations.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/features/home/presentation/screens/shop_details_screen.dart';
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

class InkWellOverlay extends StatelessWidget {
  const InkWellOverlay({
    this.openContainer,
    this.child,
  });

  final VoidCallback? openContainer;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openContainer,
      child: child,
    );
  }
}

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.item,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final ShopModel item;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return ShopDetailsScreen(shopId: item.id ?? 0, imageUrl: item.shopBg!);
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
