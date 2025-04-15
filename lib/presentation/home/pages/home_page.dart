import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_track/presentation/order-location/controllers/order_location_controller.dart';

import '../../../core/pallets.dart';
import '../../global/widgets/custom_menu_button.dart';
import '../../packing-info/controllers/packing_info_controller.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final orderLocationController = Get.find<OrderLocationController>();
    final packingInfoController = Get.find<PackingInfoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SpaceTrack',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Pallets.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Pallets.containerBgColor,
              width: Get.width,
              padding: EdgeInsets.all(16.0),
              child: const Text(
                'OUTBOUND',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomMenuButton(
              title: 'Packing Info',
              onTap: () => controller.navigateToScanPage(action: packingInfoController.onScanCode),
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            ),
            CustomMenuButton(
              title: 'Order Location',
              onTap: () => controller.navigateToScanPage(action: orderLocationController.onScanCode),
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
