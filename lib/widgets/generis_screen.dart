// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:lottie/lottie.dart';

// class WebViewScreenGeneric extends StatefulWidget {
//   final String url;

//   const WebViewScreenGeneric({super.key, required this.url});

//   @override
//   WebViewScreenGenericState createState() => WebViewScreenGenericState();
// }

// class WebViewScreenGenericState extends State<WebViewScreenGeneric> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView está cargando (progreso : $progress%)');
//             if (progress == 100) {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//           },
//           onPageStarted: (String url) {
//             debugPrint('La página comenzó a cargar: $url');
//             setState(() {
//               _isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             debugPrint('La página terminó de cargar: $url');
//             setState(() {
//               _isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('Error de recurso de página: ${error.description}');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.contains('gstatic.com') ||
//                 request.url.contains('google.com')) {
//               debugPrint('Permitiendo navegación a: ${request.url}');
//               return NavigationDecision.navigate;
//             }
//             debugPrint('Bloqueando navegación a: ${request.url}');
//             return NavigationDecision.prevent;
//           },
//         ),
//       );

//     if (_controller.platform is AndroidWebViewController) {
//       AndroidWebViewController androidController =
//           _controller.platform as AndroidWebViewController;
//       androidController.setMediaPlaybackRequiresUserGesture(false);
//     }

//     _loadUrl();
//   }

//   Future<void> _loadUrl() async {
//     try {
//       await _controller.loadRequest(Uri.parse(widget.url));
//     } catch (e) {
//       debugPrint('Error al cargar la URL: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mis visitados'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               _controller.reload();
//               setState(() {
//                 _isLoading = true;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             Container(
//               color: Colors.white,
//               child: Center(
//                 child: Lottie.asset('assets/load.json'),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
