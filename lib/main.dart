import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmenu/firebase_options.dart';
import 'package:smartmenu/helpers/notifacion_services.dart';
import 'package:smartmenu/providers/cubit/qr_cubit_cubit.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';
import 'package:smartmenu/routes/routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");

  if (message.data['url'] != null) {
    final url = message.data['url'] as String;
    print('URL from background notification: $url');
    NotificationUrlCubit().setUrl(url);
  }
}

void _showNotificationDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('New Notification'),
        content: Text('Do you want to open the link?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Open'),
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/webview?url=${Uri.encodeComponent(url)}');
            },
          ),
        ],
      );
    },
  );
}

void _initializeFirebaseMessaging(NotificationUrlCubit notificationUrlCubit) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received foreground message: ${message.messageId}");

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'drawable/notification_icon',
          ),
        ),
        payload: message.data['url'],
      );
    }

    if (message.data['url'] != null) {
      final url = message.data['url'] as String;
      print('URL from foreground notification: $url');
      notificationUrlCubit.setUrl(url);

      if (navigatorKey.currentContext != null) {
        _showNotificationDialog(navigatorKey.currentContext!, url);
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    if (message.data['url'] != null) {
      final url = message.data['url'] as String;
      notificationUrlCubit.setUrl(url);
    }
  });
}

Future<void> _requestCameraPermission() async {
  final status = await Permission.camera.request();
  if (status.isGranted) {
    print('Camera permission granted');
  } else if (status.isDenied) {
    print('Camera permission denied');
  } else if (status.isPermanentlyDenied) {
    print('Camera permission permanently denied');
    await openAppSettings();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  final notificationUrlCubit = NotificationUrlCubit();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
        notificationUrlCubit.setUrl(response.payload!);
      }
    },
  );

  _initializeFirebaseMessaging(notificationUrlCubit);

  final notificationServices = NotificationServices(notificationUrlCubit);
  await notificationServices.initialize();
  await _requestCameraPermission();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NotificationUrlCubit>.value(value: notificationUrlCubit),
        BlocProvider(create: (_) => QRCubit()),
      ],
      child: MyApp(notificationUrlCubit: notificationUrlCubit),
    ),
  );
}

class MyApp extends StatelessWidget {
  final NotificationUrlCubit notificationUrlCubit;

  const MyApp({Key? key, required this.notificationUrlCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter(notificationUrlCubit),
      builder: (context, child) {
        return BlocListener<NotificationUrlCubit, String?>(
          listener: (context, url) {
            if (url != null) {
              _showNotificationDialog(context, url);
              notificationUrlCubit.clearUrl();
            }
          },
          child: child!,
        );
      },
    );
  }
}
