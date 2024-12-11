import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_life_cycle_state.dart';
part 'app_life_cycle_cubit.freezed.dart';

@lazySingleton
class ApplicationLifeCycleCubit extends Cubit<ApplicationLifeCycleState>
    with WidgetsBindingObserver {
  ApplicationLifeCycleCubit()
      : super(const ApplicationLifeCycleState.resumed()) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        emit(const ApplicationLifeCycleState.resumed());
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        emit(const ApplicationLifeCycleState.background());
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
