import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/widgets/social_button.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: AppColors.background,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(
                icon: Icons.mail,
                onTap: () => controller.launchEmail(controller.email.value),
              ),
              const SizedBox(width: 20),
              SocialButton(
                icon: Icons.code,
                onTap: () => controller.launchUrl(controller.githubUrl.value),
              ),
              const SizedBox(width: 20),
              SocialButton(
                icon: Icons.link,
                onTap: () => controller.launchUrl(controller.linkedInUrl.value),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Designed & Built by ${controller.name.value} © ${DateTime.now().year}',
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
