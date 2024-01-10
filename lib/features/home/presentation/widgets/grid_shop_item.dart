import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/custom_page_route.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/screens/shop_details_screen.dart';
import 'package:flutter/material.dart';

class GridShopItem extends StatefulWidget {
  final ShopModel item;
  const GridShopItem(
    this.item, {
    super.key,
  });

  @override
  State<GridShopItem> createState() => _GridShopItemState();
}

class _GridShopItemState extends State<GridShopItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Hero(
              tag: widget.item.id!,
              child: CachedNetworkImage(imageUrl: widget.item.shopBg ?? '')),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            surfaceTintColor: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                Navigator.push(
                    context,
                    CustomPageRoute2(
                        builder: (_) => ShopDetailsScreen(
                            shopId: widget.item.id ?? 0,
                            imageUrl: widget.item.shopBg!)));
              },
              splashColor: ColorPalette.primaryColor.withOpacity(0.3),
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
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.item.name ?? '',
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
            ),
          ),
        ],
      ),
    );
  }
}
