import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'presentation/home/controllers/home_controller.dart';
import 'presentation/home/pages/home_page.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment variables
  await dotenv.load(fileName: "lib/env/.env");

  // Initialize app
  runApp(SpaceTrackApp());
}

class SpaceTrackApp extends StatelessWidget {
  const SpaceTrackApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    _initDependencies();

    return GetMaterialApp(
      title: 'SpaceTrack',
      theme: ThemeData(
        primaryColor: const Color(0xFF354170),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF354170),
        ),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }

  void _initDependencies() {
    // Controllers
    Get.put(HomeController());
  }
}
