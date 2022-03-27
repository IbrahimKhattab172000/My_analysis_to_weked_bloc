// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_app/business_logic/cubits/setting_c/setting_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),

      ///Bloc listener to show snackBar according to the changes of the state of our cubit
      body: BlocListener<SettingCubit, SettingState>(
        listener: (context, state) {
          ///hahah lol, do u think by creating this SnackBar you're done
          ///khkh yaste => we need to create "showSnackBar" then pass our snackBar to it
          ///that's why we made it in a final notificationSnackBar to pass it there
          final notificationSnackBar = SnackBar(
            duration: Duration(
              milliseconds: 700,
            ),
            content: Text('App is : ' +
                state.appNotifications.toString() +
                '    Mobile is : ' +
                state.mobileNotifications.toString()),
          );

          ///Now let's showSnackBar
          ///LOL, it's deprecated bruh, let's see what's the new version
          // Scaffold.of(context).showSnackBar(notificationSnackBar);
          ///Here we go the new way | btw, that's for one snackbar
          /// but I guess there is another way for multi snackBars
          /// hint: "creating scaffold Key should be considered if any issues arise"
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        child:
            BlocBuilder<SettingCubit, SettingState>(builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                ///Our first SwitchTile (for mobileNotifications)
                SwitchListTile(
                    value: state.appNotifications,
                    onChanged: (newValue) {
                      ///That's the normal way of getting access to a bloc or cubit
                      ///and call a method from it...which will emit ofc a new state" the new value"...
                      ///.. that we passed to it here accordingly

                      // BlocProvider.of<SettingCubit>(context).toggleAppNotifications(newValue);

                      ///But here's another way to do it
                      context
                          .read<SettingCubit>()
                          .toggleAppNotifications(newValue);
                    }),

                ///Our second SwitchTile (for mobileNotifications)
                SwitchListTile(
                    value: state.mobileNotifications,
                    onChanged: (newValue) {
                      context
                          .read<SettingCubit>()
                          .toggleMobileNotifications(newValue);
                    }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
