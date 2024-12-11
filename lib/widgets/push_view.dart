import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:smartmenu/screens/main_menu.dart';
import 'package:smartmenu/providers/notifaciton_services/noti_provider.dart';
import 'package:smartmenu/screens/webview.dart';

class WebViewScreeNotifi extends StatefulWidget {
  final String url;

  const WebViewScreeNotifi({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreeNotifi> {
  late WebViewController _controller;
  bool _isLoading = true;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationUrlCubit, String?>(
      listener: (context, url) {
        if (url != null) {
          _controller.loadUrl(url);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                  _controller = controller;
                },
                onPageStarted: (String url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
                onProgress: (int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
              ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Lottie.asset(
                      'assets/load.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              // Añadir la barra inferior y el botón aquí para que prevalezcan sobre el WebView
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 60, // Altura de la barra inferior
                      color: Colors.white, // Color de la barra inferior
                    ),
                    Positioned(
                      bottom: 10, // Ajusta esta posición según sea necesario
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                url:
                                    'https://www.erpsystems.cl/subirventas/appRest/home.php',
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.home),
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 0, 26, 255),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
