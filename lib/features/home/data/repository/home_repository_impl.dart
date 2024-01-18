import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/models/guild_model.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/data/data_source/home_data_source.dart';
import 'package:customer_club/features/home/data/models/discount_model.dart';
import 'package:customer_club/features/home/data/models/guild_details_model.dart';
import 'package:customer_club/features/home/data/models/home_data_model.dart';
import 'package:customer_club/features/home/data/models/shop_details_model/shop_all_details_model.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

List<GuildModel>? _guildListRes;
List<ShopModel>? _locationShopListRes;

@Injectable(
  as: IHomeRepository,
)
class HomeRepository implements IHomeRepository {
  @override
  Future<DataState<HomeDataModel>> getHomeData() async {
    try {
      final res = await getIt<IHomeDataSource>().getHomeData();
      if (res.validate()) {
        return DataSuccess(HomeDataModel.fromJson(res.data));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<List<GuildModel>>> getGuilds() async {
    try {
      if (_guildListRes != null) {
        return DataSuccess(_guildListRes);
      }
      final res = await getIt<IHomeDataSource>().getGuilds();
      if (res.validate()) {
        _guildListRes =
            (res.data as List).map((e) => GuildModel.fromJson(e)).toList();
        return DataSuccess(_guildListRes);
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<GuildDetailsModel>> getGuildDetails(int guildId) async {
    try {
      final res = await getIt<IHomeDataSource>().getGuildDetails(guildId);
      if (res.validate()) {
        return DataSuccess(GuildDetailsModel.fromJson(res.data));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<List<ShopModel>>> getLocationShops() async {
    try {
      if (_locationShopListRes != null) {
        return DataSuccess(_locationShopListRes);
      }
      final res = await getIt<IHomeDataSource>().getLocationShops();
      if (res.validate()) {
        _locationShopListRes =
            (res.data as List).map((e) => ShopModel.fromJson(e)).toList();
        return DataSuccess(_locationShopListRes);
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<ShopAllDetailsModel>> getShopDetails(int shopId) async {
    try {
      final res = await getIt<IHomeDataSource>().getShopDetails(shopId);
      if (res.validate()) {
        return DataSuccess(ShopAllDetailsModel.fromJson(res.data));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<List<DiscountModel>>> getDiscountList(int shopId) async {
    try {
      final res = await getIt<IHomeDataSource>().getDiscountList(shopId);
      if (res.validate()) {
        return DataSuccess(
            ((res.data as Map<String, dynamic>)['offers'] as List)
                .map((e) => DiscountModel.fromJson(e))
                .toList());
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<ShopModel>> getShopLocation(int shopId) async {
    try {
      final res = await getIt<IHomeDataSource>().getShopLocation(shopId);
      if (res.validate()) {
        return DataSuccess(ShopModel.fromJson(res.data));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<ShopModel>> getShopWithQR(String qr) async {
    try {
      final res = await getIt<IHomeDataSource>().getShopWithQr(qr);
      if (res.validate(checkError: true)) {
        return DataSuccess(
            ShopModel.fromJson((res.data as Map<String, dynamic>)['data']));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }

  @override
  Future<DataState<List<ShopModel>>> searchShops(String query) async {
    try {
      final res = await getIt<IHomeDataSource>().searchShops(query);
      if (res.validate(checkError: true)) {
        return DataSuccess(((res.data as Map<String, dynamic>)['data'] as List)
            .map((e) => ShopModel.fromJson(e))
            .toList());
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }
}
