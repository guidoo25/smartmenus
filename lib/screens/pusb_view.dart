// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatefulWidget {
//   final String url;

//   const WebViewScreen({Key? key, required this.url}) : super(key: key);

//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   late final WebViewController _controller;
//   bool _isLoading = true;
//   double _progress = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             setState(() {
//               _isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//           onProgress: (int progress) {
//             setState(() {
//               _progress = progress / 100;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print('Error: ${error.description}');
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(221, 0, 0, 0),
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text('WebView', style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.refresh,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               _controller.reload();
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(
//                 value: _progress,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
