import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/features/home/presentation/blocs/get_shop_details/get_shop_details_bloc.dart';
import 'package:customer_club/features/home/presentation/blocs/get_shop_location/get_shop_location_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ShopDetailsInfo extends StatefulWidget {
  final int shopId;
  const ShopDetailsInfo({super.key, required this.shopId});

  @override
  State<ShopDetailsInfo> createState() => _ShopDetailsInfoState();
}

class _ShopDetailsInfoState extends State<ShopDetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 4, right: 4),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: BlocConsumer<GetShopLocationBloc, GetShopLocationState>(
        listener: (context, locationState) {},
        builder: (context, locationState) {
          return BlocBuilder<GetShopDetailsBloc, GetShopDetailsState>(
            builder: (context, state) {
              return state is GetShopDetailsLoaded
                  ? SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 80),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'شعار تبلیغاتی شما',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          16.hsb(),
                          Text(
                            state.shopAllDetailsModel.shop?.aboutUs ?? '',
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          12.hsb(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.shopAllDetailsModel.shop!.manager
                                  .isNotNullOrEmpty)
                                _infoItem('مدیریت',
                                    state.shopAllDetailsModel.shop!.manager!),
                              if (state.shopAllDetailsModel.shop!.manager
                                  .isNotNullOrEmpty)
                                _infoItem('ساعت کار',
                                    state.shopAllDetailsModel.shop!.worktime!),
                              24.hsb(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: ColorPalette.primaryColor,
                                  ),
                                  6.wsb(),
                                  Text(
                                    'تماس با ما',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ...(state.shopAllDetailsModel.shop!.contentCat ??
                                      [])
                                  .map(
                                (e) => Directionality(
                                  textDirection: e.entries.first.key
                                          .toString()
                                          .toLowerCase()
                                          .contains('address')
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 8, right: 8),
                                    child: Row(
                                      children: [
                                        _getIconFromKey(e.entries.first.key),
                                        6.wsb(),
                                        Text(
                                          e.entries.first.value,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          24.hsb(),
                          if (locationState is GetShopLocationLoaded &&
                              locationState.shopModel.lat.isNotNullOrEmpty &&
                              locationState.shopModel.lng.isNotNullOrEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: () {
                                  MapsLauncher.launchCoordinates(
                                      double.parse(
                                          locationState.shopModel.lat ?? '0'),
                                      double.parse(
                                          locationState.shopModel.lng ?? '0'));
                                },
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: SizedBox(
                                    width: 90.w(context),
                                    height: 50.w(context),
                                    child: OSMFlutter(
                                        controller: MapController(
                                            initPosition: GeoPoint(
                                                latitude: double.parse(
                                                    locationState
                                                            .shopModel.lat ??
                                                        '0'),
                                                longitude: double.parse(
                                                    locationState
                                                            .shopModel.lng ??
                                                        '0'))),
                                        osmOption: OSMOption(
                                            staticPoints: [
                                              StaticPositionGeoPoint(
                                                  widget.shopId.toString(),
                                                  MarkerIcon(
                                                    assetMarker: AssetMarker(
                                                        scaleAssetImage: 3,
                                                        image: AssetImage(Assets
                                                            .resources
                                                            .pin
                                                            .path)),
                                                  ),
                                                  [
                                                    GeoPoint(
                                                        latitude: double.parse(
                                                            locationState
                                                                    .shopModel
                                                                    .lat ??
                                                                '0'),
                                                        longitude: double.parse(
                                                            locationState
                                                                    .shopModel
                                                                    .lng ??
                                                                '0'))
                                                  ])
                                            ],
                                            zoomOption: const ZoomOption(
                                                initZoom: 14))),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  : state is GetShopDetailsLoading
                      ? Center(
                          child: CupertinoActivityIndicator(
                              color: ColorPalette.primaryColor),
                        )
                      : const Center();
            },
          );
        },
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 8,
                color: ColorPalette.primaryColor,
              ),
              6.wsb(),
              Text(
                title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8),
            child: Text(
              value,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconFromKey(String key) {
    switch (key) {
      case 'phone':
        return SvgPicture.string(
          MyIcons.mobile,
          width: 16,
        );
      case 'address':
        return SvgPicture.string(
          MyIcons.locationSelected,
          width: 16,
        );
      case 'instagram':
        return SvgPicture.string(
          MyIcons.instagram,
          width: 16,
        );
      case 'telegram':
        return SvgPicture.string(
          MyIcons.telegram,
          width: 16,
        );
      case 'whatsapp':
        return SvgPicture.string(
          MyIcons.whatsapp,
          width: 16,
        );
      case 'website':
        return SvgPicture.string(
          MyIcons.site,
          width: 16,
        );
      default:
        return Icon(
          Icons.circle,
          size: 16,
          color: ColorPalette.primaryColor,
        );
    }
  }
}
