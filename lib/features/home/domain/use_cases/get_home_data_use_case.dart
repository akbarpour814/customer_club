import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/home/data/models/home_data_model/home_data_model.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';

class GetHomeDataUseCase extends TUseCase<DataState<HomeDataModel>> {
  @override
  Future<DataState<HomeDataModel>> call() =>
      getIt<IHomeRepository>().getHomeData();
}
