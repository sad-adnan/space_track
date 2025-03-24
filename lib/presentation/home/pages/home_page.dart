import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_route_constants.dart';
import '../../../core/pallets.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

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
              onTap: () => controller.navigateToScanPage(destination:RoutesPaths.packingInfo),
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            ),
            CustomMenuButton(
              title: 'Order Location',
              onTap: () => controller.navigateToScanPage(destination:RoutesPaths.packingInfo),
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
