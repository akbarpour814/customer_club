import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/presentation/blocs/get_home_data/get_home_data_bloc.dart';
import 'package:customer_club/features/home/presentation/widgets/grid_shop_item.dart';
import 'package:customer_club/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _scrollUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetHomeDataBloc, GetHomeDataState>(
        builder: (context, state) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.forward) {
                setState(() {
                  _scrollUp = false;
                });
              } else if (direction == ScrollDirection.reverse) {
                setState(() {
                  _scrollUp = true;
                });
              }
              return true;
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  primary: true,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _scrollUp ? 1 : 0,
                    child: const Text(
                      'تمام فروشگاه ها',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  actions: [
                    PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [],
                    ),
                  ],
                  leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                      )),
                  backgroundColor: ColorPalette.primaryColor,
                  expandedHeight: state is GetHomeDataLoaded &&
                          (state.homeDataModel.slides ?? []).isNotEmpty
                      ? 43.8.w(context)
                      : 0,
                  flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: true,
                      background: state is GetHomeDataLoaded &&
                              (state.homeDataModel.slides ?? []).isNotEmpty
                          ? HomeSlider(state.homeDataModel.slides!)
                          : null),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                      bottom: 80, left: 4, right: 4, top: 6),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: [
                      ...(state as GetHomeDataLoaded).homeDataModel.shops!,
                      ...state.homeDataModel.shops!,
                      ...state.homeDataModel.shops!,
                      ...state.homeDataModel.shops!,
                      ...state.homeDataModel.shops!,
                      ...state.homeDataModel.shops!,
                      ...state.homeDataModel.shops!
                    ].map((e) => GridShopItem(e)).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
