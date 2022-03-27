// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_app/business_logic/cubits/counter/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  final String name;
  final Color color;

  SecondScreen({Key? key, required this.name, required this.color})
      : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed the button this many times"),
            BlocConsumer<CounterCubit, CounterState>(
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).decrement();
            //         print(CounterCubit(internetCubit: ).state.counterValue);
            //       },
            //       tooltip: "Decrement",
            //       child: Icon(Icons.remove),
            //     ),
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).increment();
            //         print(CounterCubit().state.counterValue);
            //       },
            //       tooltip: "Increment",
            //       child: Icon(Icons.add),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
