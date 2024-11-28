import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smartmenu/providers/cubit/qr_cubit_cubit.dart';
import 'package:smartmenu/screens/webview.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanear QR'),
        backgroundColor: Color.fromARGB(221, 0, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<QRCubit, QRState>(
        listener: (context, state) {
          if (state is QRError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is QRLoaded && state.qrCodes.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    WebViewScreen(url: state.qrCodes.last.url),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(child: _buildQRView(context)),
              if (state is QRLoaded && state.qrCodes.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('URL: ${state.qrCodes.last.url}',
                      style: TextStyle(fontSize: 16)),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera();
        context.read<QRCubit>().scanQR(scanData.code!);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
