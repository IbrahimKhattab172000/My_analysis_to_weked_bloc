import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(

            ///Making the defaut "the initial" state of the cubit is false for both app and mobile notifications
            SettingState(
          appNotifications: false,
          mobileNotifications: false,
        ));

  /// our two functions who will emit a state which is our copywith() from SettingState{} class
  /// hence passing newvalues => to emit a new state accordingly

  ///This method will be called from our UI bu providing it there ofc, and then it will be triggered
  ///when the App notification "Tile" that we will create in pressed
  void toggleAppNotifications(bool newValue) =>

      ///Here we use state.copyWith() method which if you go to SettingState you will find that
      ///..it copies the previous one and modifies it by also sitting up the new value of appNotifications
      emit(state.copyWith(appNotifications: newValue));

  ///Have the same funcyionality of the previous but triggering another case of course which is for mobile
  void toggleMobileNotifications(bool newValue) =>

      ///The same here but sitting up the new value of  mobileNotifications
      emit(state.copyWith(mobileNotifications: newValue));

  //----------------False manner-----------------///

  ///Urgenciaaa
  ///some people might do the following

  // void tryingToToggleAppNotificationsByFalseWay(bool newValue) {
  //   ///they would take the current state modifying it directly
  //   //-YOU SHOULD NEVER MUTATE EXISTING STATE (you can access its value but never modify it)
  //   state.appNotifications = newValue;

  //   ///then subsequientely emiting it
  //   ///-BLOC WON'T CONSECUTEIVLY EMIT 2 IDENTICAL STATES
  //   ///Don't think that the state that will be emitted from here {state.appNotifications = newValue;}...
  //   ///..id different from this   {emit(state);}
  //   ///So dart knows that this state is the same as the previous emitted one
  //   ///Therefore not updating the UI
  //   emit(state);
  // }
}
