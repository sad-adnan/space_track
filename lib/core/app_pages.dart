import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:space_track/presentation/home/binding/home_binding.dart';
import '../presentation/home/pages/home_page.dart';
import 'app_route_constants.dart';


class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: RoutesPaths.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
