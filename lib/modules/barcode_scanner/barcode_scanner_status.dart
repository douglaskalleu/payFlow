import 'package:camera/camera.dart';

class BarCodeScannerStatus {
  final bool isCameraAvaliable;
  final String error;
  final String barCode;
  final bool stopScanner;

  BarCodeScannerStatus(
      {this.isCameraAvaliable = false,
      this.error = "",
      this.barCode = "",
      this.stopScanner = false});

  factory BarCodeScannerStatus.available() =>
      BarCodeScannerStatus(isCameraAvaliable: true, stopScanner: false);

  factory BarCodeScannerStatus.error(String message) =>
      BarCodeScannerStatus(error: message, stopScanner: true);

  factory BarCodeScannerStatus.barCode(String barCode) =>
      BarCodeScannerStatus(barCode: barCode, stopScanner: true);

  bool get showCamera => isCameraAvaliable && error.isEmpty;
  bool get hasError => error.isNotEmpty;
  bool get hasBarCode => barCode.isNotEmpty;
}
