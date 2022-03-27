// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_app/business_logic/cubits/counter/counter_cubit.dart';
import 'package:startup_app/business_logic/cubits/internet/internet_cubit.dart';
import 'package:startup_app/constants/enums.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final Color color;

  HomeScreen({Key? key, required this.name, required this.color})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //USING BLOCLISTENR INSTEAD OF STREAMSUBSCRIBTION TO COMMUNICATE BTEWEEN 2 CUBITS//
    ///BlocListener just "listen" so it's safe to place it at the top of the tree...
    ///..[ie. which is the scaffold in out case]...
    ///...since it [ie. BlocListener] won't rebuild anything...
    ///.. so we can use it to listen to specific bloc or cubit and act accordingly...
    ///...<Notice just changing the[state]of the cubit but not building anything in the UI>
    return
        // BlocListener<InternetCubit, InternetState>(
        //   listener: (context, state) {
        //     if (state is InternetConnected &&
        //         state.connectionType == ConnectionType.Wifi) {
        //       ///BlocProvider porvides us with...
        //       ///...access to whatever inside that spscific bloc or cubit
        //       ///... so that we change its state
        //       BlocProvider.of<CounterCubit>(context).increment();
        //     } else if (state is InternetConnected &&
        //         state.connectionType == ConnectionType.Mobile) {
        //       //BlocProvider porvides us with...
        //       ///...access to whatever inside that spscific bloc or cubit
        //       ///... so that we change its state
        //       BlocProvider.of<CounterCubit>(context).decrement();
        //     }
        //   },
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/setting");
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///BlocBuilder listen and rebuild so we put it right above it widget
            ///Here it rebuilds the UI everytime someting changes
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text("Wifi");
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text("Mobile");
                } else if (state is InternetDisconnected) {
                  return Text("Disconnected");
                }
                return CircularProgressIndicator();
              },
            ),
            // Text("You have pushed the button this many times"),
            SizedBox(
              height: 50,
            ),

            ///Here BlocConsumer in this listener part it just build or let's say
            ///... show a snackBar without building the whole UI
            /// & in the {builder} it rebuild the whole UI accordingly
            BlocConsumer<CounterCubit, CounterState>(
              ///Subtle change
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Increment"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Decremented"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },

              ///huge and full change[i.e. rebuild]
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    "BRR Negative" + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    "Yayy " + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    "Hmm number 5",
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),

            ///Trying to rebuild the UI{i.e. our Builder} based on 2 cubits by using
            ///{context.watch<CounterCubit>().state;} & {context.watch<InternetCubit>().state;}
            ///... and rebuild the Builder every time each state of any one of them changes
            ///Notice => When I used it I found a problem with the return
            ///it was like that => {The body might complete normally, causing 'null' to be returned,..
            /// ..but the return type is a potentially non-nullable type.Try adding either a return or..
            /// ..a throw statement at the end].
            /// even if I tried to return empty container(), but it ruined it all
            //=>
            // Builder(builder: (context) {
            //   final counterState = context.watch<CounterCubit>().state;
            //   final internetState = context.watch<InternetCubit>().state;
            //   if (internetState is InternetConnected &&
            //       internetState.connectionType == ConnectionType.Mobile) {
            //     return Text(
            //       'counter: ' +
            //           counterState.counterValue.toString() +
            //           '  Internet: ' +
            //           ' Mobile ',
            //     );
            //   } else if (internetState is InternetConnected &&
            //       internetState.connectionType == ConnectionType.Wifi) {
            //     Text('counter:  ' +
            //         counterState.counterValue.toString() +
            //         '   internet: ' +
            //         ' Wifi');
            //   } else {
            //     return Text(
            //       'counter: ' +
            //           counterState.counterValue.toString() +
            //           '  internet: ' +
            //           '  Disconnected',
            //     );
            //   }
            // }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "tag1",
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    print(CounterCubit().state.counterValue);
                  },
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: "tag2",
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                    print(CounterCubit().state.counterValue);
                  },
                  tooltip: "Increment",
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: Text(
                "Go to second screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              child: Text(
                "Go to third screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
