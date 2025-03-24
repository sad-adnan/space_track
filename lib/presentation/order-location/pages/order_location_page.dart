import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_track/core/pallets.dart';
import 'package:space_track/core/app_styles.dart';
import 'package:space_track/generated/assets.dart';

import '../../packing-info/widgets/section_container.dart';
import '../controllers/order_location_controller.dart';

class OrderLocationPage extends StatelessWidget {
  const OrderLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderLocationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Pallets.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Barcode',
                                  style: AppStyles.labelStyle,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  controller.scanCode.value,
                                  style: AppStyles.valueStyle,
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Image.asset(
                                Assets.pngScan,
                                height: 20,
                                width: 20,
                                color: Colors.black,
                              ),
                              onPressed: () => controller.navigateToScanPage(),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),

                      Obx(() {
                        return Padding(
                          padding: AppStyles.sectionPadding,
                          child: DottedBorder(
                            color: Colors.grey,
                            dashPattern: const [4, 4],
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(4),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Location",style: TextStyle(fontSize: 20,),),
                                  SizedBox(height: 5,),
                                  Text(
                                    controller.locationData.value,
                                    style: const TextStyle(
                                        fontSize: 40,fontWeight: FontWeight.bold,),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // No submit button
            ],
          );
        }),
      ),
    );
  }
}
