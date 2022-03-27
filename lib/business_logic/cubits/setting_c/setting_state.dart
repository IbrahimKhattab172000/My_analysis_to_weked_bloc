part of 'setting_cubit.dart';

class SettingState extends Equatable {
  bool appNotifications;
  bool mobileNotifications;

  SettingState({
    required this.appNotifications,
    required this.mobileNotifications,
  });

  ///Step 1: press on class SettingState{} create copywith
  ///but what is the idea of it => //*Mira,
  /// what it's essentially does that it's create ..
  ///.. a new instance of the SettingStste class by copying the previous one..
  ///..and then inside the method's parameters you can mention which field you want..
  ///... to modify after it gets created
  SettingState copyWith({
    bool? appNotifications,
    bool? mobileNotifications,
  }) {
    return SettingState(
      appNotifications: appNotifications ?? this.appNotifications,
      mobileNotifications: mobileNotifications ?? this.mobileNotifications,
    );
  }

  //! You should put all the variables inside the props
  @override
  List<Object?> get props => [
        appNotifications,
        mobileNotifications,
      ];

  ///To see the state in more details in lib\business_logic\utility\app_bloc_observer.dart
  @override
  String toString() =>
      'SettingState(appNotifications: $appNotifications, mobileNotifications: $mobileNotifications)';
}
