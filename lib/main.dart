// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:startup_app/business_logic/cubits/counter/counter_cubit.dart';
import 'package:startup_app/business_logic/cubits/internet/internet_cubit.dart';
import 'package:startup_app/business_logic/cubits/setting_c/setting_cubit.dart';
import 'package:startup_app/business_logic/utility/app_bloc_observer.dart';
import 'package:startup_app/presntation/router/app_router.dart';

///Stream example
// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
//
// void main(List<String> args) async {
//   Stream<int> stream= boatStream();
//   stream.listen((receivedData) {
//     print("Received boat no." + receivedData.toString());
//   });
//
// }
//
// Stream<int> boatStream() async* {
//   for(int i =1; i<=10; i++ ){
//     print("sent boat no." + i.toString());
//     await Future.delayed(Duration(seconds: 2));
//     yield i;
//   }
// }

void main() async {
  ////One of the steps for Saving the data using HydratedBloc

  ///important => and since the plugin needs to use platform channels to call the native code,
  /// which is done asynchronously therefore you have to call ensureInitialized()
  ///to make sure that you have an instance of the WidgetsBinding.
  WidgetsFlutterBinding.ensureInitialized();

  ///#video no. 11 => using hydratedBloc to save our data
  //!NOTICE ==> HydratedBlocOverrides.runZoned() is a new way to manage everything here
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  final appObserver = AppObserver();
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    )),
    storage: storage,
    blocObserver: appObserver,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingCubit>(
          create: (context) => SettingCubit(),

          ///By default the lazy bool is true which means that it will just be created once it's needed
          ///...however if we set it to false it means it will get created once we open the app
          // lazy: false,
        ),
      ],
      child: MaterialApp(
        title: "Testing",
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
