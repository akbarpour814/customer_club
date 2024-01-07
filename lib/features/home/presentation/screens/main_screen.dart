import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/custom_page_route.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/screens/guild_list_screen.dart';
import 'package:customer_club/features/home/presentation/screens/home_screen.dart';
import 'package:customer_club/features/home/presentation/screens/map_shops_screen.dart';
import 'package:customer_club/features/home/presentation/widgets/bottom_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  final GlobalKey<NavigatorState> _locationKey = GlobalKey();
  final GlobalKey<NavigatorState> _guildsKey = GlobalKey();

  late final map = {
    profileIndex: _profileKey,
    searchIndex: _searchKey,
    homeIndex: _homeKey,
    guildsIndex: _guildsKey,
    locationIndex: _locationKey,
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorPalette.primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _history.isEmpty,
      onPopInvoked: (value) async {
        if (!value) {
          setState(() {
            _selectedScreenIndex = _history.last;
            _history.removeLast();
          });
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: MainScreen.scaffoldKey,
          body: Stack(
            children: [
              SizedBox(
                width: 100.w(context),
                height: 100.h(context),
                child: IndexedStack(
                  index: _selectedScreenIndex,
                  children: [
                    _navigator(_profileKey, profileIndex, const Center()),
                    _navigator(
                      _searchKey,
                      searchIndex,
                      const Center(),
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
                          image:
                              AssetImage(Assets.resources.bottomBarBg1.path))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => onChangeTab(profileIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuProfile.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuProfile
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == profileIndex),
                      ),
                      InkWell(
                        onTap: () => onChangeTab(searchIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuSearch.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuSearch
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == searchIndex),
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
                              child: Assets.resources.menuHome
                                  .image(width: 26, height: 26),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => onChangeTab(locationIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuLocations.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuLocations
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == locationIndex),
                      ),
                      InkWell(
                        onTap: () => onChangeTab(guildsIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuGuild.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuGuild
                                .image(height: 22, width: 22),
                            isSelected: _selectedScreenIndex == guildsIndex),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChangeTab(int index) {
    setState(() {
      _history.remove(_selectedScreenIndex);
      _history.add(_selectedScreenIndex);
      _selectedScreenIndex = index;
    });
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && _selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => CustomPageRoute(Offstage(
                offstage: _selectedScreenIndex != index,
                child: Directionality(
                    textDirection: TextDirection.rtl, child: child))));
  }
}
