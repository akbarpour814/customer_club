import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/custom_page_route.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/screens/shop_details_screen.dart';
import 'package:flutter/material.dart';

class GuildDetailsShopItemWidget extends StatelessWidget {
  final ShopModel item;
  const GuildDetailsShopItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CustomPageRoute2(
                builder: (_) => ShopDetailsScreen(
                    shopId: item.id ?? 0, imageUrl: item.shopBg ?? '')));
      },
      child: Hero(
        tag: item.id ?? 0,
        child: Container(
          height: 56.w(context),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(item.shopBg ?? '')),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.only(right: 4, top: 8, bottom: 8, left: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.1)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              (item.rating ?? 0) > 4
                                  ? Icons.star_rate_rounded
                                  : Icons.star_border_rounded,
                              color: (item.rating ?? 0) > 4
                                  ? ColorPalette.goldColor
                                  : Colors.white,
                            ),
                            Icon(
                              (item.rating ?? 0) >= 4
                                  ? Icons.star_rate_rounded
                                  : Icons.star_border_rounded,
                              color: (item.rating ?? 0) >= 4
                                  ? ColorPalette.goldColor
                                  : Colors.white,
                            ),
                            Icon(
                              (item.rating ?? 0) >= 3
                                  ? Icons.star_rate_rounded
                                  : Icons.star_border_rounded,
                              color: (item.rating ?? 0) >= 3
                                  ? ColorPalette.goldColor
                                  : Colors.white,
                            ),
                            Icon(
                              (item.rating ?? 0) >= 2
                                  ? Icons.star_rate_rounded
                                  : Icons.star_border_rounded,
                              color: (item.rating ?? 0) >= 2
                                  ? ColorPalette.goldColor
                                  : Colors.white,
                            ),
                            Icon(
                              (item.rating ?? 0) >= 1
                                  ? Icons.star_rate_rounded
                                  : Icons.star_border_rounded,
                              color: (item.rating ?? 0) >= 1
                                  ? ColorPalette.goldColor
                                  : Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
