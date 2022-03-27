import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  //* Every constuctor has a body {} but we don't use it unless we need
  CounterCubit()
      : super(
          CounterState(counterValue: 0, wasIncremented: true),
        );

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  //One of the steps for Saving the data using HydratedBloc
  ///#video no. 11 => using hydratedBloc to save our data

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    ///We were just adding error to chech if "onError" down there works or not
    //  addError(Exception("Something went wrong",),StackTrace.current);
    return state.toMap();
  }

  ///Observing and tracing our cubit-------------

  //!WHY ON EARTH WE COMMENTED THEM? => Because we will use BlocObserver to manage...
  ///... all the bloc and cubits not just one {Take a look at business_logic\utility\app_bloc_observer}

  ///OnChange=>
  // @override
  // void onChange(Change<CounterState> change) {
  //   // print("current : " +
  //   //     change.currentState.toString() +
  //   //     " Next : " +
  //   //     change.nextState.toString());

  //   ///After maintaining some stuff in CounterState now we can just use it directly like this=>
  //   print(change);

  //   super.onChange(change);
  // }

  // ///OnError=>
  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print("$error" + "$stackTrace");
  //   super.onError(error, stackTrace);
  // }
}
