import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/core/widgets/my_loading.dart';
import 'package:customer_club/features/home/presentation/blocs/get_shop_rating/get_shop_rating_bloc.dart';
import 'package:customer_club/features/home/presentation/widgets/commnt_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetailsComments extends StatefulWidget {
  final int shopId;
  const ShopDetailsComments({super.key, required this.shopId});

  @override
  State<ShopDetailsComments> createState() => _ShopDetailsCommentsState();
}

class _ShopDetailsCommentsState extends State<ShopDetailsComments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 4, right: 4),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: BlocBuilder<GetShopRatingBloc, GetShopRatingState>(
        builder: (context, state) {
          return state is GetShopRatingLoaded && state.commentList.isNotEmpty
              ? ListView(
                  padding: EdgeInsets.only(bottom: 80),
                  physics: BouncingScrollPhysics(),
                  children: state.commentList
                      .where((element) => element.comment.isNotNullOrEmpty)
                      .map((e) => CommentItem(
                            comment: e,
                          ))
                      .toList(),
                )
              : state is GetShopRatingLoading
                  ? Center(
                      child: MyLoading(),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'برای این فروشگاه تاکنون نظری ثبت نشده است',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
