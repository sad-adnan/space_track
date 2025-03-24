import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:space_track/core/app_config.dart';
import 'package:space_track/core/pallets.dart';

import 'core/app_pages.dart';
import 'core/app_route_constants.dart';
import 'data/models/order_location_model.dart';
import 'data/models/packing_info_model.dart';

void main() async {
  //if no flavor is passed we will use the dev flavor
  await mainInitializations(AppFlavor.dev);
}

Future<void> mainInitializations(AppFlavor environment) async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the environment
  await AppConfig.initializeEnvironment(environment);

  // Initialize the Scandit Library
  await ScanditFlutterDataCaptureBarcode.initialize();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(PackingInfoModelAdapter());
  Hive.registerAdapter(OrderLocationModelAdapter());

  // Open Hive boxes
  final packingInfoBox = await Hive.openBox<PackingInfoModel>('packingInfo');
  Get.put<Box<PackingInfoModel>>(packingInfoBox);

  final orderLocationBox = await Hive.openBox<OrderLocationModel>('orderLocation');
  Get.put<Box<OrderLocationModel>>(orderLocationBox);

  // If the orderLocation box is empty, will add 10 random entries
  if (orderLocationBox.isEmpty) {
    for (int i = 0; i < 10; i++) {
      final orderId = 'FO${1000 + i}';
      final location = generateRandomLocation();
      final orderLocationEntry = OrderLocationModel(orderId: orderId, location: location);
      await orderLocationBox.put(orderId, orderLocationEntry);
    }
  }

  // Initialize app
  runApp(SpaceTrackApp());
}

String generateRandomLocation() {
  final random = Random();
  String twoDigits() => (random.nextInt(90) + 10).toString();

  return '${twoDigits()}K-${twoDigits()}LB-OB-B-${twoDigits()}-A${twoDigits()}';
}

class SpaceTrackApp extends StatelessWidget {
  const SpaceTrackApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpaceTrack${!AppConfig.isProd ? " - ${AppConfig.environment.name.toUpperCase()}" : ""}',
      theme: ThemeData(
        primaryColor: Pallets.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallets.primaryColor,
        ),
      ),
      initialRoute: RoutesPaths.home,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    );
  }
}