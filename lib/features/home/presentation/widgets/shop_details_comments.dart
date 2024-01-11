import 'package:customer_club/features/home/presentation/blocs/get_discount_list/get_discount_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetailsComments extends StatefulWidget {
  final int shopId;
  const ShopDetailsComments({super.key, required this.shopId});

  @override
  State<ShopDetailsComments> createState() =>
      _ShopDetailsCommentsState();
}

class _ShopDetailsCommentsState extends State<ShopDetailsComments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: BlocBuilder<GetDiscountListBloc, GetDiscountListState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          );
        },
      ),
    );
  }
}
