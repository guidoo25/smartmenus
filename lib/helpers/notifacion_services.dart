import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationUrlCubit notificationUrlCubit;

  NotificationServices(this.notificationUrlCubit);

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    await _handleInitialMessage();
    await getDeviceToken();
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    print('Handling a background message: ${message.messageId}');
    if (message.data['url'] != null) {
      final url = message.data['url'] as String;
      print('URL from background notification: $url');
      notificationUrlCubit.setUrl(url);
    }
  }

  Future<void> _handleInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('Handling a message that opened the app from terminated state');
      if (initialMessage.data['url'] != null) {
        final url = initialMessage.data['url'] as String;
        print('URL from initial notification: $url');
        notificationUrlCubit.setUrl(url);
      }
    }
  }

  Future<String?> getDeviceToken() async {
    print('Getting device token');
    final token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('fcm_token', token);
    }
  }
}
