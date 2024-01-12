import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/data/models/shop_details_model/shop_gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageFullScreen extends StatefulWidget {
  final ShopGalleryModel item;
  const ImageFullScreen({super.key, required this.item});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name ?? 'نمونه کار'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: widget.item.image ?? '',
              width: 100.w(context),
            ),
          ),
        ),
      ),
    );
  }
}
