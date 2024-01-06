import 'package:customer_club/core/models/guild_model.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/home/data/models/guild_details_model.dart';
import 'package:customer_club/features/home/data/models/home_data_model.dart';

abstract class IHomeRepository {
  Future<DataState<HomeDataModel>> getHomeData();
  Future<DataState<List<GuildModel>>> getGuilds();
  Future<DataState<GuildDetailsModel>> getGuildDetails(int guildId);
}
