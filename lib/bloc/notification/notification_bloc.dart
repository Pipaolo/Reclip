import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is NotificationConfigured) {
      _mapNotificationConfiguredToState();
    }
  }

  Stream<NotificationState> _mapNotificationConfiguredToState() async* {
    if (Platform.isIOS) {
      firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
    });
  }
}
