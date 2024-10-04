import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/login/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ShowVirtualCardAlert extends StatelessWidget {
  final UserModel data;
  const ShowVirtualCardAlert({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: SizedBox(
          width: 80.w(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CloseButton(),
                ],
              ),
              16.hsb(),
              CachedNetworkImage(
                imageUrl: data.idcardImg ?? '',
                progressIndicatorBuilder: (_, __, ___) =>
                    CupertinoActivityIndicator(
                  color: ColorPalette.primaryColor,
                ),
                fit: BoxFit.contain,
                width: 60.w(context),
                height: 60.w(context),
              ),
              16.hsb(),
              Text(
                data.expireDay!,
                style: TextStyle(color: Colors.green.shade700),
              ),
              8.hsb(),
              Text(
                '${data.idcard!.toPersianDigit().substring(0, 4)}-${data.idcard!.toPersianDigit().substring(4, 8)}-${data.idcard!.toPersianDigit().substring(8, 12)}-${data.idcard!.toPersianDigit().substring(12, 16)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.primaryColor),
              ),
              8.hsb(),
              Text(
                '${data.fname ?? ''} ${data.lname ?? ''}',
                style: TextStyle(color: Colors.grey),
              ),
              24.hsb()
            ],
          ),
        ),
      ),
    );
  }
}
