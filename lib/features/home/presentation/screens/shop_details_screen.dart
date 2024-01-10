import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatefulWidget {
  final int shopId;
  final String imageUrl;
  const ShopDetailsScreen(
      {super.key, required this.shopId, required this.imageUrl});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: widget.shopId,
                child: CachedNetworkImage(
                  width: 100.w(context),
                  imageUrl: widget.imageUrl,
                ))
          ],
        ),
      )),
    );
  }
}
