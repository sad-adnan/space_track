import 'package:get/get.dart';
import 'package:space_track/core/app_route_constants.dart';
import '../../../domain/usecases/get_order_location_info_usecase.dart';

class OrderLocationController extends GetxController {
  final GetOrderLocationUseCase getOrderLocationUseCase;

  OrderLocationController({
    required this.getOrderLocationUseCase,
  });

  final isLoading = false.obs;
  final isDataSaved = false.obs;
  final scanCode = ''.obs;
  final locationData = ''.obs;


  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    // Assuming the scanned code (orderId) is passed as a String argument.
    if (args is String) {
      scanCode.value = args;
      loadExistingData();
    }
  }

  Future<void> loadExistingData() async {
    isLoading.value = true;
    try {
      final orderLocation = await getOrderLocationUseCase.execute(scanCode.value);
      if (orderLocation != null) {
        locationData.value = orderLocation.location;
        isDataSaved.value = true;
      } else {
        locationData.value = 'No location data available';
        isDataSaved.value = false;
      }
    } catch (e) {
      Get.log('Error loading order location: $e');
      locationData.value = 'Error loading data';
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToScanPage() {
    Get.offAndToNamed(
      RoutesPaths.scan,
      arguments: {
        'scanAction': (String barcodeData) {
          Get.offAndToNamed(RoutesPaths.orderLocation, arguments: barcodeData);
        },
      },
    );
  }
}
