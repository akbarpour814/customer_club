import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  final List<String> sliderItems;
  const HomeSlider(this.sliderItems, {super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _index = index;
                });
              },
              autoPlayInterval: const Duration(seconds: 8)),
          items: widget.sliderItems
              .map(
                (e) => Image.network(
                  e,
                  fit: BoxFit.cover,
                  width: 100.w(context),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: widget.sliderItems.length,
                axis: Axis.horizontal,
                position: _index,
                decorator: DotsDecorator(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    size: const Size(4, 10),
                    activeSize: const Size(4, 16),
                    activeColor: ColorPalette.primaryColor,
                    spacing: const EdgeInsets.fromLTRB(2, 8, 2, 8),
                    color: Colors.grey.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
