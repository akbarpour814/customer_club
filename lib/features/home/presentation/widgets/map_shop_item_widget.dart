import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapShopItemWidegt extends StatelessWidget {
  final ShopModel item;
  const MapShopItemWidegt({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 90.w(context),
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 90,
            margin: const EdgeInsets.only(left: 8, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image:
                    DecorationImage(image: NetworkImage(item.shopImg ?? ''))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.hsb(),
                Text(
                  item.name ?? '',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                6.hsb(),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.person_pin,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                    4.wsb(),
                    Text(
                      item.manager ?? '',
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                6.hsb(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.directions,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                    4.wsb(),
                    Expanded(
                      child: Text(
                        item.address ?? '',
                        style: const TextStyle(fontSize: 10),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    MapsLauncher.launchCoordinates(
                        double.parse(item.lat ?? '0'),
                        double.parse(item.lng ?? '0'));
                  },
                  icon: Icon(
                    Icons.assistant_direction_sharp,
                    color: ColorPalette.primaryColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
