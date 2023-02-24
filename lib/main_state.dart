class CounterState {
  final int counter;
  final String name;


  CounterState({this.counter = 0, this.name = ""});

  CounterState copyWith({
    String? name,
    int? counter,
  }) =>
      CounterState(
        name: name ?? this.name,
        counter: counter ?? this.counter,
      );
}
