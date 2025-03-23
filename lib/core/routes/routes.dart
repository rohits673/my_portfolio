import 'package:get/get.dart';
import 'package:my_portfolio/presentation/bindings/home_binding.dart';
import 'package:my_portfolio/presentation/screens/home/home_screen.dart';

class AppRoutes {
  static const String home = '/home';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
