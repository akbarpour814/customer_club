import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/home/data/models/home_data_model/home_data_model.dart';

abstract class IHomeRepository {
  Future<DataState<HomeDataModel>> getHomeData();}
