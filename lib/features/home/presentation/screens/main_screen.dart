import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/custom_page_route.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/screens/home_screen.dart';
import 'package:customer_club/features/home/presentation/widgets/bottom_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static GlobalKey<MainScreenState> stateKey = GlobalKey();

  @override
  State<MainScreen> createState() => MainScreenState();
}

const int catIndex = 0;
const int cartIndex = 1;
const int homeIndex = 2;
const int favoriteIndex = 3;
const int profileIndex = 4;

class MainScreenState extends State<MainScreen> {
  int _selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _favoriteKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    catIndex: _categoryKey,
    cartIndex: _cartKey,
    homeIndex: _homeKey,
    profileIndex: _profileKey,
    favoriteIndex: _favoriteKey,
  };

  @override
  void initState() {
    super.initState();
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
                    _navigator(_categoryKey, catIndex, const Center()),
                    _navigator(
                      _cartKey,
                      cartIndex,
                      const Center(),
                    ),
                    _navigator(_homeKey, homeIndex, const HomeScreen()),
                    _navigator(_favoriteKey, favoriteIndex, const Center()),
                    _navigator(_profileKey, profileIndex, const Center()),
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
                        onTap: () => onChangeTab(catIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuProfile.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuProfile
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == catIndex),
                      ),
                      InkWell(
                        onTap: () => onChangeTab(cartIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuSearch.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuSearch
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == cartIndex),
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
                        onTap: () => onChangeTab(favoriteIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuLocations.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuLocations
                                .image(height: 24, width: 24),
                            isSelected: _selectedScreenIndex == favoriteIndex),
                      ),
                      InkWell(
                        onTap: () => onChangeTab(profileIndex),
                        child: BottomMenuItem(
                            selectedIcon: Assets.resources.menuGuild.image(
                                color: ColorPalette.primaryColor,
                                height: 24,
                                width: 24),
                            unSelectedIcon: Assets.resources.menuGuild
                                .image(height: 22, width: 22),
                            isSelected: _selectedScreenIndex == profileIndex),
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
