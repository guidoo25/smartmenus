// lib/models/qr_data.dart
class QRData {
  final int idR;
  final int m;
  final String p;

  QRData({required this.idR, required this.m, required this.p});

  factory QRData.fromText(String text, String token) {
    final parts = text.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid QR code format');
    }
    return QRData(
      idR: int.parse(parts[0]),
      m: int.parse(parts[1]),
      p: token,
    );
  }

  String get url =>
      'https://www.subirventas.com/appRest/index.php?idR=$idR&m=$m&p=$p';

  Map<String, dynamic> toJson() => {
        'idR': idR,
        'm': m,
        'p': p,
      };

  factory QRData.fromJson(Map<String, dynamic> json) => QRData(
        idR: json['idR'],
        m: json['m'],
        p: json['p'],
      );
}
