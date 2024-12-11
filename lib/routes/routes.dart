import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';
import 'package:smartmenu/screens/main_menu.dart';
import 'package:smartmenu/screens/webview.dart';
import 'package:smartmenu/widgets/push_view.dart';

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
          final url = state.uri.queryParameters['url'] ??
              notificationUrlCubit.state ??
              'https://example.com';
          print('WebView route: URL is $url');
          return WebViewScreeNotifi(url: url);
        },
      ),
    ],
    redirect: (context, state) {
      final notificationUrl = notificationUrlCubit.state;
      if (notificationUrl != null) {
        print('Redirecting to WebView with URL: $notificationUrl');
        notificationUrlCubit.clearUrl();
        return '/webview?url=${Uri.encodeComponent(notificationUrl)}';
      }
      return null;
    },
  );
}
