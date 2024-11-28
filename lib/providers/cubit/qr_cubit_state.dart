part of 'qr_cubit_cubit.dart';

abstract class QRState extends Equatable {
  const QRState();

  @override
  List<Object> get props => [];
}

class QRInitial extends QRState {}

class QRLoaded extends QRState {
  final List<QRData> qrCodes;

  const QRLoaded({required this.qrCodes});

  @override
  List<Object> get props => [qrCodes];
}

class QRError extends QRState {
  final String message;

  const QRError({required this.message});

  @override
  List<Object> get props => [message];
}
