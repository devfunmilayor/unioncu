part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.initial(int initial) = _Initial;
  const factory CounterState.loading() = _Loading;
  const factory CounterState.loaded(int newNumber) = _Loaded;
  const factory CounterState.erorr(
      {String? message, int? lastNumberBeforeError}) = _Error;
}
