import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';

class GetShopLocationUseCase
    extends TPUseCase<DataState<ShopModel>, int> {
  @override
  Future<DataState<ShopModel>> call(param) =>
      getIt<IHomeRepository>().getShopLocation(param);
}
