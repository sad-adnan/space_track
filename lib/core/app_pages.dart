import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:space_track/presentation/home/binding/home_binding.dart';
import 'package:space_track/presentation/packing-info/pages/packing_info_page.dart';
import 'package:space_track/presentation/scan/binding/scan_binding.dart';
import 'package:space_track/presentation/scan/pages/scan_page.dart';
import '../presentation/home/pages/home_page.dart';
import '../presentation/packing-info/binding/packing_info_binding.dart';
import 'app_route_constants.dart';


class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: RoutesPaths.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesPaths.scan,
      page: () => const ScanPage(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: RoutesPaths.packingInfo,
      page: () => const PackingInfoPage(),
      binding: PackingInfoBinding()
    ),
  ];
}
