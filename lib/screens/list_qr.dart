// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smartmenu/models/qrmodel.dart';
// import 'package:smartmenu/providers/cubit/qr_cubit_cubit.dart';
// import 'package:smartmenu/widgets/generis_screen.dart';

// class QRListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mis Restaurantes', style: TextStyle(color: Colors.white)),
//       ),
//       body: BlocBuilder<QRCubit, QRState>(
//         builder: (context, state) {
//           if (state is QRLoaded) {
//             return ListView.builder(
//               itemCount: state.qrCodes.length,
//               itemBuilder: (context, index) {
//                 return _buildQRCodeCard(context, state.qrCodes[index]);
//               },
//             );
//           } else if (state is QRError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navegar a la pantalla de escaneo QR
//           // Implementa esta navegación
//         },
//         child: Icon(Icons.qr_code_scanner),
//         backgroundColor: Color.fromARGB(255, 0, 26, 255),
//       ),
//     );
//   }

//   Widget _buildQRCodeCard(BuildContext context, QRData qrData) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => WebViewScreenGeneric(url: qrData.url),
//             ),
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 204, 221, 255),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Icon(Icons.restaurant,
//                     color: Color.fromARGB(255, 0, 26, 255), size: 30),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Restaurante',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Toca para ver el menú',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(Icons.arrow_forward_ios,
//                   color: Color.fromARGB(255, 0, 26, 255)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
