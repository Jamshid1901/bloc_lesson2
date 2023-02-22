import 'package:bloc_lesson/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<MainState> {
  CounterCubit() : super(MainState(counter: 0, name: ""));

  void increment() {
    emit(MainState(counter: state.counter + 1, name: state.name));
  }

  void decrement() {
    emit(MainState(counter: state.counter - 1, name: state.name));
  }

  void addName(String name) {
    emit(MainState(counter: state.counter, name: name));
  }
}
