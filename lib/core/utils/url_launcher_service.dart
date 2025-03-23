import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService extends GetxService {
  Future<void> launchMyUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch $url',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch email client',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch phone dialer',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
