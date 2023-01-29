part of 'counter_cubit.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.initial(int initial) = _Initial;
  const factory CounterState.loading() = _Loading;
  const factory CounterState.loaded() = _Loaded;
  const factory CounterState.erorr(String meessgae, int lastNumberBeforeError) =
      _Error;
}
