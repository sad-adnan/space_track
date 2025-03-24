import 'package:get/get.dart';
import 'package:space_track/core/app_route_constants.dart';

class HomeController extends GetxController {
  void navigateToScanPage({required String destination}) {
    Get.toNamed(
      RoutesPaths.scan,
      arguments: {'destinationRoute': destination},
    );
  }
}
