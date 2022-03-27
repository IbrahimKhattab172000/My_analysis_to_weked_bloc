// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:startup_app/presntation/screens/home_screen.dart';
import 'package:startup_app/presntation/screens/second_screen.dart';
import 'package:startup_app/presntation/screens/setting_screen.dart';
import 'package:startup_app/presntation/screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(name: "First", color: Colors.blueAccent));
      // break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) =>
                SecondScreen(name: "Second", color: Colors.redAccent));
      // break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) =>
                ThirdScreen(name: "Third", color: Colors.greenAccent));
      // break;
      case '/setting':
        return MaterialPageRoute(builder: (_) => SettingScreen());
      default:
        return _errorRoute();
    }
  }

  ///Pay attention yastaaa this method isn't like the built-in method, but =>
  /// I've created it to call it in main.dart
  // void dispose() {
  //   _counterCubit.close();
  // }
}

///Here I had to create a dummy route to place it up there as a returned route
///... in case something went wrong with the other routes
Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Something went wrong! \n Page not found"),
      ),
    );
  });
}

///-----------------------------------------------
///class AppRouter {

///My old AppRouter where we use BlocProvider.value

//   final CounterCubit _counterCubit = CounterCubit();

//   Route onGenerateRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case '/':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                   value: _counterCubit,
//                   child: HomeScreen(name: "First", color: Colors.blueAccent),
//                 ));
//       // break;
//       case '/second':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                   value: _counterCubit,
//                   child: SecondScreen(name: "Second", color: Colors.redAccent),
//                 ));
//       // break;
//       case '/third':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider.value(
//                   value: _counterCubit,
//                   child: ThirdScreen(name: "Third", color: Colors.greenAccent),
//                 ));
//       // break;
//       default:
//         return _errorRoute();
//     }
//   }

//   ///Pay attention yastaaa this method isn't like the built-in method, but =>
//   /// I've created it to call it in main.dart
//   void dispose() {
//     _counterCubit.close();
//   }
// }

// Route<dynamic> _errorRoute() {
//   return MaterialPageRoute(builder: (context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Error"),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text("Something went wrong! \n Page not found"),
//       ),
//     );
//   });
// }
