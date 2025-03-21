import 'package:get/get.dart';
import 'package:space_track/presentation/scan/controllers/scan_controller.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanController());
  }
}