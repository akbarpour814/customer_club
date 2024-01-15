import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/models/guild_model.dart';
import 'package:customer_club/core/widgets/animated_expanded_widget.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/home/presentation/blocs/get_guild_details/get_guild_details_bloc.dart';
import 'package:customer_club/features/home/presentation/widgets/guild_details_shop_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuildDetailsScreen extends StatefulWidget {
  final GuildModel item;
  const GuildDetailsScreen({super.key, required this.item});

  @override
  State<GuildDetailsScreen> createState() => _GuildDetailsScreenState();
}

class _GuildDetailsScreenState extends State<GuildDetailsScreen> {
  bool _scrollUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetGuildDetailsBloc()
        ..add(
          GetGuildDetailsStartEvent(guildId: widget.item.id ?? 0),
        ),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<GetGuildDetailsBloc, GetGuildDetailsState>(
            builder: (context, state) {
              return Column(
                children: [
                  AnimatedExpandedWidget(
                      expand: !_scrollUp,
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        leading: state is GetGuildDetailsLoaded
                            ? Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Center(
                                  child: Image.network(
                                      state.guildDetailsModel.category?.icon ??
                                          '',
                                      width: 30,
                                      height: 30),
                                ),
                              )
                            : const SizedBox(
                                width: 30,
                              ),
                        title: Text(
                          widget.item.name ?? 'دسته بندی',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: ColorPalette.primaryColor,
                      )),
                  Expanded(
                    child: state is GetGuildDetailsLoaded &&
                            (state.guildDetailsModel.shops ?? []).isNotEmpty
                        ? NotificationListener<UserScrollNotification>(
                            onNotification: (notification) {
                              final ScrollDirection direction =
                                  notification.direction;
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
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 80, left: 6, right: 6),
                              children: (state.guildDetailsModel.shops ?? [])
                                  .map((e) => GuildDetailsShopItemWidget(e))
                                  .toList(),
                            ))
                        : state is GetGuildDetailsLoaded &&
                                (state.guildDetailsModel.shops ?? []).isEmpty
                            ? const Center(
                                child: Text('فروشگاهی یافت نشده است!'),
                              )
                            : state is GetGuildDetailsLoading
                                ? MyLoading()
                                : const Center(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
