// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/home/data/data_source/home_data_source.dart' as _i616;
import '../features/home/data/repository/home_repository_impl.dart' as _i722;
import '../features/home/domain/repository/home_repository.dart' as _i855;
import '../features/login/data/data_source/login_data_source.dart' as _i110;
import '../features/login/data/repository/login_repository_impl.dart' as _i718;
import '../features/login/domain/repository/login_repository.dart' as _i533;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i616.IHomeDataSource>(() => _i616.HomeDataSource());
    gh.factory<_i855.IHomeRepository>(() => _i722.HomeRepository());
    gh.factory<_i533.ILoginRepository>(() => _i718.LoginRepository());
    gh.factory<_i110.ILoginDataSource>(() => _i110.LoginDataSource());
    return this;
  }
}
