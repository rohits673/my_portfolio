import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/social_button.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class SocialSidebar extends StatelessWidget {
  const SocialSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    if (ResponsiveUtils.isMobile(context)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SocialButton(
            icon: Icons.mail,
            onTap: () => controller.launchEmail(controller.email.value),
          ),
          const SizedBox(height: 20),
          SocialButton(
            icon: Icons.code,
            onTap: () => controller.launchUrl(controller.githubUrl.value),
          ),
          const SizedBox(height: 20),
          SocialButton(
            icon: Icons.link,
            onTap: () => controller.launchUrl(controller.linkedInUrl.value),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.3),
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
