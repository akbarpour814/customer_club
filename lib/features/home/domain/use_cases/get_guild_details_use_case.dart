import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/home/data/models/guild_details_model.dart';
import 'package:customer_club/features/home/domain/repository/home_repository.dart';

class GetGuildDetailsUseCase
    extends TPUseCase<DataState<GuildDetailsModel>, int> {
  @override
  Future<DataState<GuildDetailsModel>> call(param) =>
      getIt<IHomeRepository>().getGuildDetails(param);
}
