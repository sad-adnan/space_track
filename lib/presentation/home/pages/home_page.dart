import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/pallets.dart';
import '../controllers/home_controller.dart';

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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: controller.navigateToScanPage,
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.8),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Packing Info',
                    style: TextStyle(
                      color: Pallets.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
