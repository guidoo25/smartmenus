import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:smartmenu/screens/main_menu.dart';

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
    return Scaffold(
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
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset(
                    'assets/load.json',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  if (await _controller.canGoBack()) {
                    _controller.goBack();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  MaterialPageRoute(builder: (context) => LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
