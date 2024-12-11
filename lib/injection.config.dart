// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:map_tutorial_template/application/app_life_cycle/app_life_cycle_cubit.dart'
    as _i255;
import 'package:map_tutorial_template/application/permission/permission_cubit.dart'
    as _i537;
import 'package:map_tutorial_template/domain/permission/i_permission_service.dart'
    as _i700;
import 'package:map_tutorial_template/infrastructure/permisson/permission_service.dart'
    as _i617;

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
    gh.lazySingleton<_i255.ApplicationLifeCycleCubit>(
        () => _i255.ApplicationLifeCycleCubit());
    gh.lazySingleton<_i700.IPermissionService>(() => _i617.PermissionService());
    gh.lazySingleton<_i537.PermissionCubit>(
        () => _i537.PermissionCubit(gh<_i700.IPermissionService>()));
    return this;
  }
}
