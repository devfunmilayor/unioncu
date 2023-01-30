import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:unioncu/util/fake_it.dart';

part 'counter_state.dart';
part 'counter_cubit.freezed.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState.initial(0));
  final faker = FakeDataGenerator();
  void incrementData(int inc) async {
    try {
      emit(const CounterState.loading());
      final resp = await faker.increment(inc);
      emit(CounterState.loaded(resp));
    } catch (e) {
      emit(CounterState.erorr(
          message: e.toString(), lastNumberBeforeError: inc));
    }
  }

  void decrement(int inc) async {
    try {
      emit(const CounterState.loading());
      final resp = await faker.decrement(inc);
      emit(CounterState.loaded(resp));
    } catch (e) {
      emit(CounterState.erorr(
          message: e.toString(), lastNumberBeforeError: inc));
    }
  }

  void resetCounter() {
    emit(const CounterState.initial(0));
  }
}
