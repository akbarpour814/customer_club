import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridShopItem extends StatelessWidget {
  final ShopModel item;
  const GridShopItem(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47.w(context),
      height: 37.w(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(image: NetworkImage(item.shopBg!))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 30,
            padding: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black.withOpacity(0.0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      item.name ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 3.w(context),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
