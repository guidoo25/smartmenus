import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmenu/models/qrmodel.dart';

part 'qr_cubit_state.dart';

class QRCubit extends Cubit<QRState> {
  QRCubit() : super(QRInitial()) {
    loadSavedQRCodes();
  }

  Future<void> scanQR(String qrCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('fcm_token') ?? '';

      final qrData = QRData.fromText(qrCode, token);
      emit(QRLoaded(qrCodes: [qrData]));
    } catch (e) {
      emit(QRError(message: 'Error al procesar el código QR: $e'));
    }
  }

  Future<void> saveQRCode(QRData qrData) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCodes = prefs.getStringList('saved_qr_codes') ?? [];
    savedCodes.add(json.encode(qrData.toJson()));
    await prefs.setStringList('saved_qr_codes', savedCodes);
  }

  Future<List<QRData>> getSavedQRCodes() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCodes = prefs.getStringList('saved_qr_codes') ?? [];
    return savedCodes
        .map((code) => QRData.fromJson(json.decode(code)))
        .toList();
  }

  Future<void> loadSavedQRCodes() async {
    final codes = await getSavedQRCodes();
    emit(QRLoaded(qrCodes: codes));
  }
}
