import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/blocs/get_shops_location/get_shops_location_bloc.dart';
import 'package:customer_club/features/home/presentation/widgets/map_shop_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:latlong2/latlong.dart';

class MapShopsScreen extends StatefulWidget {
  const MapShopsScreen({super.key});

  @override
  State<MapShopsScreen> createState() => _MapShopsScreenState();
}

class _MapShopsScreenState extends State<MapShopsScreen>
    with TickerProviderStateMixin {
  MapController _mapController = MapController();
  List<Marker> _shopMarkerList = [];
  List<ShopModel> _shopList = [];
  double _centerLat = 0;
  double _centerLng = 0;
  int _index = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = GetShopsLocationBloc();
        bloc.add(GetShopsLocationStartEvent());
        return bloc;
      },
      child: BlocConsumer<GetShopsLocationBloc, GetShopsLocationState>(
        buildWhen: (previous, current) => previous != current,
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is GetShopsLocationLoaded) {
            _shopList = state.shopList;

            double lat = 0;
            double lng = 0;
            for (var element in _shopList) {
              lat += double.parse(element.lat ?? '0');
              lng += double.parse(element.lng ?? '0');
            }
            _fillMarkerList();
            setState(() {
              _centerLat = lat / _shopList.length;
              _centerLng = lng / _shopList.length;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: state is GetShopsLocationLoaded &&
                        state.shopList.isNotEmpty
                    ? FlutterMap(
                        options: MapOptions(
                            interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.pinchZoom |
                                    InteractiveFlag.drag),
                            initialCenter: LatLng(_centerLat, _centerLng),
                            initialZoom: 12,
                            maxZoom: 15),
                        mapController: _mapController,
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            // 'https://map.ir/shiveh/xyz/1.0.0/Shiveh:Shiveh@EPSG:3857@png/{z}/{x}/{y}.png?x-api-key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIxZGU5NDM3MGE5OTNmZTQ0ZDJlYTZkYmQ1MWQ2YWUzY2UyMzgwOWM1YjM0YmQ5OWY4Mzg1MzJjOTIyMjk1OWE4OWJlMDRhZjBjNDI3NDU4In0.eyJhdWQiOiI0NTUzIiwianRpIjoiMjFkZTk0MzcwYTk5M2ZlNDRkMmVhNmRiZDUxZDZhZTNjZTIzODA5YzViMzRiZDk5ZjgzODUzMmM5MjIyOTU5YTg5YmUwNGFmMGM0Mjc0NTgiLCJpYXQiOjE1NjQ5MDM5OTMsIm5iZiI6MTU2NDkwMzk5MywiZXhwIjoxNTY3NTgyMzkyLCJzdWIiOiIiLCJzY29wZXMiOlsiYmFzaWMiXX0.Qkt6pQwFdtaGMwZPBT3t0Nm8P_ui9KyDqJOtlWRYf5pP3lsj-dT94Tfvrz7rz1Ps4IahhPd7zPhar_UKhHRfBUA9igmVHrongABM_KF7iQecnIurfAGFUKr76sVr-rox_-PQ6PkAB84P4x5nMoHpsPcGKuLljjZEmMSaGlxy6rZrFzKU8pCdtrHmrh0mnPd0iUWiyKfTtP8bBbYuj_uoqZ5vrXXzXfGpElGvQsnIcfeQ6y6g87u67gi2TwQxtTbXV_Xariy5X16UZrqY1IDyop_TR3qBGIsWVXCcwIeyoDlNrRX0SIZdgN6iQsLAdCiGRs0KAUO2p5ZIeLqXY2zknw',
                            subdomains: const ['a', 'b', 'c'],
                            tileProvider: NetworkTileProvider(),
                            userAgentPackageName: 'com.app.royacard',
                          ),
                          MarkerClusterLayerWidget(
                            options: MarkerClusterLayerOptions(
                              maxClusterRadius: 45,
                              size: const Size(40, 40),
                              alignment: Alignment.center,
                              maxZoom: 12,
                              markers: _shopMarkerList,
                              onMarkerTap: (p0) {
                                _carouselController.animateToPage(_shopList
                                    .indexOf(_shopList.firstWhere((element) =>
                                        element.lat ==
                                            p0.point.latitude.toString() &&
                                        element.lng ==
                                            p0.point.longitude.toString())));
                              },
                              polygonOptions: PolygonOptions(
                                  borderColor: ColorPalette.primaryColor,
                                  color: Colors.black12,
                                  borderStrokeWidth: 3),
                              builder: (context, markers) {
                                return FloatingActionButton(
                                  onPressed: null,
                                  heroTag: "btn${Random().nextInt(100000000)}",
                                  backgroundColor: ColorPalette.primaryColor,
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 110,
                                margin: const EdgeInsets.only(bottom: 80),
                                width: 100.w(context),
                                child: CarouselSlider(
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.9,
                                    onPageChanged: (index, reason) async {
                                      setState(() {
                                        _index = index;
                                      });
                                      _animatedMapMove(
                                          LatLng(
                                              double.parse(
                                                  _shopList[_index].lat ?? '0'),
                                              double.parse(
                                                  _shopList[_index].lng ??
                                                      '0')),
                                          _mapController.camera.zoom);
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      _shopList[_index]
                                          .contrller!
                                          .showTooltip();
                                    },
                                  ),
                                  items: _shopList
                                      .map((e) => MapShopItemWidegt(item: e))
                                      .toList(),
                                ),
                              ))
                        ],
                      )
                    : state is GetShopsLocationLoading
                        ? Center(
                            child: CupertinoActivityIndicator(
                              color: ColorPalette.primaryColor,
                            ),
                          )
                        : const Center(
                            child: Text('فروشگاهی یافت نشده است.'),
                          )),
          );
        },
      ),
    );
  }

  void _fillMarkerList() {
    _shopMarkerList = _shopList
        .map(
          (e) => Marker(
              width: 40,
              height: 40,
              point: LatLng(
                  double.parse(e.lat ?? '0'), double.parse(e.lng ?? '0')),
              child: JustTheTooltip(
                  controller: e.contrller,
                  preferredDirection: AxisDirection.up,
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      e.name ?? '',
                    ),
                  ),
                  child: Assets.resources.pin.image(width: 40, height: 40))),
        )
        .toList();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.camera.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.camera.center.longitude,
        end: destLocation.longitude);
    final zoomTween =
        Tween<double>(begin: _mapController.camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
