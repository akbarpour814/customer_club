import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/color_palette.dart';
import 'package:customer_club/core/utils/custom_page_route.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/utils/my_icons.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/features/home/presentation/screens/guild_list_screen.dart';
import 'package:customer_club/features/home/presentation/screens/home_screen.dart';
import 'package:customer_club/features/home/presentation/screens/map_shops_screen.dart';
import 'package:customer_club/features/home/presentation/screens/search_screen.dart';
import 'package:customer_club/features/home/presentation/screens/shop_details_screen.dart';
import 'package:customer_club/features/home/presentation/widgets/bottom_menu_item.dart';
import 'package:customer_club/features/login/presentation/screens/login_intro_screen.dart';
import 'package:customer_club/features/login/presentation/screens/profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static GlobalKey<MainScreenState> stateKey = GlobalKey();
  @override
  State<MainScreen> createState() => MainScreenState();
}

const int profileIndex = 0;
const int searchIndex = 1;
const int homeIndex = 2;
const int locationIndex = 3;
const int guildsIndex = 4;

class MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [homeIndex];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  final GlobalKey<NavigatorState> _locationKey = GlobalKey();
  final GlobalKey<NavigatorState> _guildsKey = GlobalKey();

  late final _map = {
    profileIndex: _profileKey,
    searchIndex: _searchKey,
    homeIndex: _homeKey,
    guildsIndex: _guildsKey,
    locationIndex: _locationKey,
  };
  StreamSubscription? _uniLinkSub;

  @override
  void initState() {
    super.initState();
    _initUniLink();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null &&
          initialMessage.data.isNotEmpty &&
          initialMessage.data['page'] != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _handleNotif(initialMessage);
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty && message.data['page'] != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _handleNotif(message);
        });
      }
    });
  }

  Future<void> _initUniLink() async {
    final initialLink = await AppLinks().getInitialAppLinkString();
    _handleUnilink(initialLink);
    _uniLinkSub = AppLinks().uriLinkStream.listen((uri) {
      _handleUnilink(uri.toString());
    }, onError: (err) {});
  }

  void _handleUnilink(String? initialLink) {
    if (initialLink.isNotNullOrEmpty &&
        initialLink!.toLowerCase().contains('/shop/') &&
        initialLink.toLowerCase().split('/shop/').last.isNumeric()) {
      Navigator.push(
          context,
          CustomPageRoute2(
              builder: (_) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ShopDetailsScreen(
                        shopId: int.parse(
                            initialLink.toLowerCase().split('/shop/').last),
                        imageUrl: ''),
                  )));
    }
  }

  @override
  void dispose() {
    _uniLinkSub?.cancel();
    super.dispose();
  }

  void _handleNotif(RemoteMessage message) {
    if (message.data['page'] == 'profile') {
      onChangeTab(0);
    } else if (message.data['page'] == 'shop' &&
        message.data['id'] != null &&
        message.data['img_url'] != null) {
      Navigator.push(
          context,
          CustomPageRoute2(
              builder: (_) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ShopDetailsScreen(
                        shopId: int.parse(message.data['id']),
                        imageUrl: message.data['img_url']),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _history.isEmpty &&
          _map[homeIndex]!.currentContext != null &&
          !Navigator.canPop(_map[homeIndex]!.currentContext!),
      onPopInvoked: (value) {
        if (!value) {
          if (Navigator.canPop(_map[selectedScreenIndex]!.currentContext!)) {
            Navigator.pop(_map[selectedScreenIndex]!.currentContext!);
          } else if (_history.isNotEmpty) {
            setState(() {
              selectedScreenIndex = _history.last;
              _history.removeLast();
            });
          }
        }
      },
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: MainScreen.scaffoldKey,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: ColorPalette.primaryColor,
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: 100.w(context),
                  height: 100.h(context),
                  child: IndexedStack(
                    index: selectedScreenIndex,
                    children: [
                      _navigator(
                          _profileKey,
                          profileIndex,
                          ValueListenableBuilder(
                              valueListenable: tokenNotifire,
                              builder: (context, token, _) {
                                return token.isNotNullOrEmpty
                                    ? const ProfileScreen()
                                    : const LoginIntroScreen();
                              })),
                      _navigator(
                        _searchKey,
                        searchIndex,
                        const SearchScreen(),
                      ),
                      _navigator(_homeKey, homeIndex, const HomeScreen()),
                      _navigator(
                          _locationKey, locationIndex, const MapShopsScreen()),
                      _navigator(
                          _guildsKey, guildsIndex, const GuildListScreen()),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 100.w(context),
                    height: 80,
                    padding: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                Assets.resources.bottomBarBg1.path))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => onChangeTab(profileIndex),
                          child: BottomMenuItem(
                              selectedIcon:
                                  SvgPicture.string(MyIcons.profileSelected),
                              unSelectedIcon:
                                  SvgPicture.string(MyIcons.profile),
                              isSelected: selectedScreenIndex == profileIndex),
                        ),
                        InkWell(
                          onTap: () => onChangeTab(searchIndex),
                          child: BottomMenuItem(
                              selectedIcon:
                                  SvgPicture.string(MyIcons.searchSelected),
                              unSelectedIcon: SvgPicture.string(MyIcons.search),
                              isSelected: selectedScreenIndex == searchIndex),
                        ),
                        Container(
                          width: 14.w(context),
                          height: 14.w(context),
                          margin: EdgeInsets.fromLTRB(
                              3.w(context), 0, 3.w(context), 8),
                          decoration: BoxDecoration(
                              color: ColorPalette.primaryColor,
                              shape: BoxShape.circle),
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            margin: EdgeInsets.zero,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () => onChangeTab(2),
                              child: Center(
                                child: SvgPicture.string(MyIcons.home),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => onChangeTab(locationIndex),
                          child: BottomMenuItem(
                              selectedIcon:
                                  SvgPicture.string(MyIcons.locationSelected),
                              unSelectedIcon:
                                  SvgPicture.string(MyIcons.location),
                              isSelected: selectedScreenIndex == locationIndex),
                        ),
                        InkWell(
                          onTap: () => onChangeTab(guildsIndex),
                          child: BottomMenuItem(
                              selectedIcon:
                                  SvgPicture.string(MyIcons.categorySelected),
                              unSelectedIcon:
                                  SvgPicture.string(MyIcons.category),
                              isSelected: selectedScreenIndex == guildsIndex),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChangeTab(int index) {
    if (selectedScreenIndex == index) {
      if (selectedScreenIndex == profileIndex) {
        Navigator.popUntil(_map[index]!.currentContext!,
            (route) => route.navigator == _profileKey.currentState);
      } else {
        Navigator.popUntil(
            _map[index]!.currentContext!, (route) => route.isFirst);
      }
    } else {
      setState(() {
        _history.remove(selectedScreenIndex);
        _history.add(selectedScreenIndex);
        selectedScreenIndex = index;
      });
    }
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => CustomPageRoute(Offstage(
                offstage: selectedScreenIndex != index,
                child: Directionality(
                    textDirection: TextDirection.rtl, child: child))));
  }
}
