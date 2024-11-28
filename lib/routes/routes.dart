import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';
import 'package:smartmenu/screens/main_menu.dart';
import 'package:smartmenu/screens/webview.dart';

GoRouter appRouter(NotificationUrlCubit notificationUrlCubit) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/webview',
        builder: (context, state) {
          final url =
              state.uri.queryParameters['url'] ?? notificationUrlCubit.state;
          print('WebView route: URL is $url');
          if (url == null) {
            return const Center(child: Text('No URL provided'));
          }
          return WebViewScreen(url: url);
        },
      ),
    ],
    redirect: (context, state) {
      final notificationUrl = notificationUrlCubit.state;
      if (notificationUrl != null && state.fullPath != '/webview') {
        // Solo redirige si la URL es válida
        print('Redirecting to WebView with URL: $notificationUrl');
        notificationUrlCubit.clearUrl(); // Limpia la URL después de redirigir
        return '/webview?url=$notificationUrl';
      }
      return null;
    },
  );
}
