import 'package:get/get.dart';
import 'package:my_portfolio/core/utils/url_launcher_service.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => UrlLauncherService());
  }
}
