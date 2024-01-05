import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/home/data/data_source/home_data_source.dart';
import 'package:customer_club/features/home/data/models/home_data_model/home_data_model.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

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
}
