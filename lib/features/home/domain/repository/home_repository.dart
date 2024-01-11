import 'package:customer_club/core/models/guild_model.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/home/data/models/discount_model.dart';
import 'package:customer_club/features/home/data/models/guild_details_model.dart';
import 'package:customer_club/features/home/data/models/home_data_model.dart';
import 'package:customer_club/features/home/data/models/shop_details_model/shop_all_details_model.dart';

abstract class IHomeRepository {
  Future<DataState<HomeDataModel>> getHomeData();
  Future<DataState<List<GuildModel>>> getGuilds();
  Future<DataState<GuildDetailsModel>> getGuildDetails(int guildId);
  Future<DataState<List<ShopModel>>> getLocationShops();
  Future<DataState<ShopAllDetailsModel>> getShopDetails(int shopId);
  Future<DataState<List<DiscountModel>>> getDiscountList(int shopId);
}
