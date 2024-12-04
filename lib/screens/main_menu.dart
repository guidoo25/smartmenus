import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmenu/models/qrmodel.dart';
import 'package:smartmenu/providers/cubit/qr_cubit_cubit.dart';
import 'package:smartmenu/screens/home.dart';
import 'package:smartmenu/screens/list_qr.dart';
import 'package:smartmenu/screens/webview.dart';
import 'package:smartmenu/widgets/push_view.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<String> generateUrlWithToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('fcm_token') ?? '';
  final String qrData =
      "https://www.subirventas.com/appRest/index.php?p=$token";
  return qrData;
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<String>(
        future: generateUrlWithToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final url = snapshot.data!;
            return _buildLoginContent(url);
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildLoginContent(String url) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.blue.shade50],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                child: Center(
                  child:
                      Image.asset('assets/logo.jpg', width: 100, height: 100),
                ),
              ),
              SizedBox(height: 60),

              // Título
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),

              // Subtítulo
              Text(
                'Presiona el botón para escanear el código QR',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),

              _buildQRButton("Escanear QR", QRScannerScreen(),
                  CupertinoIcons.qrcode_viewfinder),

              SizedBox(height: 20),
              _buildQRButton("Mis sitios", WebViewScreeNotifi(url: url),
                  CupertinoIcons.location_solid),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRButton(String valuetext, Widget ruta, IconData icono) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ruta,
          ),
        );
      },
      icon: Icon(icono, color: Colors.white, size: 28),
      label: Text(
        '${valuetext}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 0, 26, 255),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        shadowColor: Colors.blue.shade200,
      ),
    );
  }
}
