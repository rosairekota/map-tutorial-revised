part of 'app_life_cycle_cubit.dart';

@freezed
class ApplicationLifeCycleState with _$ApplicationLifeCycleState {
  const ApplicationLifeCycleState._();
  const factory ApplicationLifeCycleState.resumed() = _Resumed;
  const factory ApplicationLifeCycleState.background() = _Background;

  bool get isResumed => maybeMap(
        resumed: (_) => true,
        orElse: () => false,
      );
}
