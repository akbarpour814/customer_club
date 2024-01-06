import 'package:customer_club/configs/gen/assets.gen.dart';
import 'package:customer_club/configs/gen/color_palette.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/widgets/animated_expanded_widget.dart';
import 'package:customer_club/features/home/presentation/blocs/get_guild/get_guild_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuildListScreen extends StatefulWidget {
  const GuildListScreen({super.key});

  @override
  State<GuildListScreen> createState() => _GuildListScreenState();
}

class _GuildListScreenState extends State<GuildListScreen> {
  bool _scrollUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetGuildBloc()
        ..add(
          GetGuildStartEvent(),
        ),
      child: SafeArea(
        child: Column(
          children: [
            AnimatedExpandedWidget(
                expand: !_scrollUp,
                child: AppBar(
                  leading: Center(
                      child: Assets.resources.menuGuild
                          .image(width: 20, height: 20, color: Colors.white)),
                  title: const Text(
                    'دسته بندی اصناف',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: ColorPalette.primaryColor,
                )),
            Expanded(
              child: NotificationListener<UserScrollNotification>(
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
              }, child: BlocBuilder<GetGuildBloc, GetGuildState>(
                builder: (context, state) {
                  return state is GetGuildLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : state is GetGuildLoaded
                          ? GridView.count(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 80),
                              children: [...state.guildList, ...state.guildList]
                                  .map((e) => Column(
                                        children: [
                                          Image.network(
                                            e.icon ?? '',
                                            width: 30.w(context),
                                          ),
                                          SizedBox(
                                            width: 40.w(context),
                                            child: Text(
                                              e.name ?? '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ))
                                  .toList(),
                            )
                          : const Center();
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
