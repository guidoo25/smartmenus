import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmenu/firebase_options.dart';
import 'package:smartmenu/helpers/notifacion_services.dart';
import 'package:smartmenu/providers/cubit/qr_cubit_cubit.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';
import 'package:smartmenu/routes/routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");

  if (message.data['url'] != null) {
    final url = message.data['url'] as String;
    print('URL from background notification: $url');

    // Establecer la URL en el cubo
    NotificationUrlCubit().setUrl(url);

    // Lógica adicional de navegación (si la app está en segundo plano)
    // Si la app está en segundo plano, navegar a la pantalla de WebView.
    if (NotificationUrlCubit().state != null) {
      // Aquí deberías asegurarte de que se navegue a la pantalla correcta.
      // Esto depende de cómo estés gestionando las rutas.
      // Podrías usar algo como el `context` o una herramienta de navegación para forzar la redirección.
    }
  }
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

  final notificationUrlCubit = NotificationUrlCubit();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter(notificationUrlCubit),
    );
  }
}
