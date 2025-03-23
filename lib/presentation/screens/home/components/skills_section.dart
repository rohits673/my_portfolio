import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/animated_progress_bar.dart';
import 'package:my_portfolio/core/widgets/section_header.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class SkillsSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const SkillsSection({
    required this.sectionKey,
  }) : super(key: sectionKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      color: AppColors.surfaceDark,
      padding: ResponsiveUtils.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'My Skills'),

          // Primary Skills
          const Text(
            'Primary Skills',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => Wrap(
                spacing: isMobile ? 0 : 20,
                runSpacing: 20,
                children: controller.primarySkills
                    .map((skill) => SkillCard(
                          title: skill.title,
                          level: skill.level,
                          percentage: skill.percentage,
                        ))
                    .toList(),
              )),

          const SizedBox(height: 40),

          // Secondary Skills
          const Text(
            'Secondary Skills',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => Wrap(
                spacing: isMobile ? 0 : 20,
                runSpacing: 20,
                children: controller.secondarySkills
                    .map((skill) => SkillCard(
                          title: skill.title,
                          level: skill.level,
                          percentage: skill.percentage,
                        ))
                    .toList(),
              )),

          const SizedBox(height: 40),

          // Soft Skills
          const Text(
            'Soft Skills',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => Wrap(
                spacing: 10,
                runSpacing: 15,
                children: controller.softSkills
                    .map((skill) => SoftSkillChip(title: skill))
                    .toList(),
              )),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String title;
  final String level;
  final double percentage;

  const SkillCard({
    Key? key,
    required this.title,
    required this.level,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.surfaceGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            level,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          AnimatedProgressBar(
            percentage: percentage,
          ),
        ],
      ),
    );
  }
}

class SoftSkillChip extends StatelessWidget {
  final String title;

  const SoftSkillChip({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: AppColors.surfaceGradient,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 16,
        ),
      ),
    );
  }
}
