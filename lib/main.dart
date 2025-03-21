import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scandit_flutter_datacapture_barcode/scandit_flutter_datacapture_barcode.dart';
import 'package:space_track/core/pallets.dart';

import 'core/app_pages.dart';
import 'core/app_route_constants.dart';
import 'data/models/packing_info_model.dart';
import 'generated/assets.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize the Scandit Library
  await ScanditFlutterDataCaptureBarcode.initialize();

  // Initialize environment variables
  await dotenv.load(fileName: Assets.env);

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(PackingInfoModelAdapter());

  // Open Hive boxes
  final packingInfoBox = await Hive.openBox<PackingInfoModel>('packingInfo');
  Get.put<Box<PackingInfoModel>>(packingInfoBox);

  // Initialize app
  runApp(SpaceTrackApp());
}

class SpaceTrackApp extends StatelessWidget {
  const SpaceTrackApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpaceTrack',
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