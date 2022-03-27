import 'package:bloc/bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
  }
}


///---------------------------------------------------------------
///Let's try this => Copied one 

// class MyBlocObserver extends BlocObserver {
//   @override
//   void onCreate(BlocBase bloc) {
//     super.onCreate(bloc);
//     print('onCreate -- ${bloc.runtimeType}');
//   }

//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('onChange -- ${bloc.runtimeType}, $change');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print('onError -- ${bloc.runtimeType}, $error');
//     super.onError(bloc, error, stackTrace);
//   }

//   @override
//   void onClose(BlocBase bloc) {
//     super.onClose(bloc);
//     print('onClose -- ${bloc.runtimeType}');
//   }
// }
