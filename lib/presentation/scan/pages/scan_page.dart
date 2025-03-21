import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_spark_scan.dart';

import '../controllers/scan_controller.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  final ScanController _controller = Get.put(ScanController());

  @override
  void initState() {
    super.initState();
    _controller.resetNavigated();
    WidgetsBinding.instance.addObserver(this);
    _controller.checkPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    var sparkScanView = SparkScanView.forContext(
      getWidgetBody(),
      _controller.dataCaptureContext,
      _controller.sparkScan,
      _controller.sparkScanViewSettings,
    )..feedbackDelegate = _controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(child: Center(child: sparkScanView)),
    );
  }

  Widget getWidgetBody() => Container();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
