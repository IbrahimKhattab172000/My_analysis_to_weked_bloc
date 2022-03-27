part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;
  bool wasIncremented;

  CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  ///One of the steps for Saving the data using HydratedBloc
  ///#video no. 11 => using hydratedBloc to save our data

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue']?.toInt() ?? 0,
      wasIncremented: map['wasIncremented'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  ///To see the state in more details in lib\business_logic\utility\app_bloc_observer.dart
  @override
  String toString() =>
      'CounterState(counterValue: $counterValue, wasIncremented: $wasIncremented)';
}
