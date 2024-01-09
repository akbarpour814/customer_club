import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/models/shop_model.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';

class GetShopLocationUseCase extends TUseCase<DataState<List<ShopModel>>> {
  @override
  Future<DataState<List<ShopModel>>> call() =>
      getIt<IHomeRepository>().getLocationShops();
}