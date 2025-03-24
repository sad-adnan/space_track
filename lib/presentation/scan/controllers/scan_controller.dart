import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_spark_scan.dart';
import 'package:scandit_flutter_datacapture_core/scandit_flutter_datacapture_core.dart';
import 'package:space_track/core/app_route_constants.dart';


class ScanController extends GetxController implements SparkScanListener, SparkScanFeedbackDelegate {

  final DataCaptureContext _dataCaptureContext = DataCaptureContext.forLicenseKey(dotenv.env['SCANDIT_LICENSE_KEY'] ?? '');
  DataCaptureContext get dataCaptureContext => _dataCaptureContext;

  late SparkScan _sparkScan;
  SparkScan get sparkScan => _sparkScan;

  late SparkScanViewSettings _sparkScanViewSettings;
  SparkScanViewSettings get sparkScanViewSettings => _sparkScanViewSettings;


  bool _hasNavigated = false; // A flag to ensure we navigate only once per scan.

  @override
  void onInit() {
    super.onInit();
    _init();
    checkPermission();
  }

  resetNavigated() {
    _hasNavigated = false;
  }

  void _init() {

    var sparkScanSettings = SparkScanSettings();

    sparkScanSettings.enableSymbologies({
      Symbology.ean13Upca,
      Symbology.ean8,
      Symbology.upce,
      Symbology.code39,
      Symbology.code128,
      Symbology.interleavedTwoOfFive,
      Symbology.qr,
      Symbology.microQr,
      Symbology.codabar,
    });

    var symbologySettings = sparkScanSettings.settingsForSymbology(Symbology.code39);
    symbologySettings.activeSymbolCounts = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};

    _sparkScan = SparkScan.withSettings(sparkScanSettings);
    _sparkScan.addListener(this);

    _sparkScanViewSettings = SparkScanViewSettings();
  }


  void checkPermission() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      print("Camera permission denied!!");
    }
  }

  @override
  void onClose() {
    _sparkScan.removeListener(this);
    super.onClose();
  }


  @override
  Future<void> didScan(SparkScan sparkScan, SparkScanSession session, Future<FrameData> Function() getFrameData) async {
    var barcode = session.newlyRecognizedBarcode;
    if (barcode == null) return;

    if (_isValidBarcode(barcode) && !_hasNavigated) {
      _hasNavigated = true;

      final destinationRoute = Get.arguments?['destinationRoute'] ?? RoutesPaths.packingInfo;
      Get.offAndToNamed(destinationRoute, arguments: barcode.data);
    }
  }

  bool _isValidBarcode(Barcode barcode) {
    return barcode.data != null && barcode.data != "123456789";
  }

  @override
  Future<void> didUpdateSession(SparkScan sparkScan, SparkScanSession session, Future<FrameData> Function() getFrameData) async {

  }


  @override
  SparkScanBarcodeFeedback? feedbackForBarcode(Barcode barcode) {
    if (_isValidBarcode(barcode)) {
      return SparkScanBarcodeSuccessFeedback();
    } else {
      return SparkScanBarcodeErrorFeedback.fromMessage('Wrong barcode', Duration(seconds: 60));
    }
  }
}
