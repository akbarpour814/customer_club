import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/guild_model.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_navigator.dart';
import 'package:customer_club/features/home/presentation/screens/guild_details_screen.dart';
import 'package:flutter/material.dart';

class GuildItemWidget extends StatelessWidget {
  final GuildModel item;
  const GuildItemWidget(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.network(
              item.icon ?? '',
              width: 30.w(context),
            ),
            Card(
              elevation: 0,
              color: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              margin: EdgeInsets.zero,
              child: InkWell(
                onTap: () {
                  MyNavigator.push(context,
                      GuildDetailsScreen(item: item));
                },
                splashColor: ColorPalette.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15.w(context)),
                child: Container(
                  width: 30.w(context),
                  height: 30.w(context),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 40.w(context),
          child: Text(
            item.name ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
