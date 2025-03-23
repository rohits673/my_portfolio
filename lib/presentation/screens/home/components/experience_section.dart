import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/section_header.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class ExperienceSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const ExperienceSection({
    required this.sectionKey,
  }) : super(key: sectionKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      color: AppColors.surfaceDark,
      padding: ResponsiveUtils.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Work Experience'),

          // Experience Timeline
          Column(
            children: controller.experiences
                .map((experience) =>
                    ExperienceTimelineItem(experience: experience))
                .toList(),
          ),

          const SizedBox(height: 60),

          const Text(
            'Education & Achievements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 30),

          // Education
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
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
                const Text(
                  'Education',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...controller.education
                    .map((edu) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: EducationItem(education: edu),
                        ))
                    .toList(),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Achievements
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
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
                const Text(
                  'Achievements',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...controller.achievements
                    .map((achievement) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: AchievementItem(
                            title: achievement['title']!,
                            description: achievement['description']!,
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceTimelineItem extends StatelessWidget {
  final dynamic experience;

  const ExperienceTimelineItem({
    Key? key,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
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
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = ResponsiveUtils.isMobile(context);
              return isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.role,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: Text(
                            experience.duration,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          experience.role,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: Text(
                            experience.duration,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 8),
          Text(
            '${experience.company}, ${experience.location}',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          ...experience.responsibilities
              .map((responsibility) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_right,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            responsibility,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class EducationItem extends StatelessWidget {
  final dynamic education;

  const EducationItem({
    Key? key,
    required this.education,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.school,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.degree,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${education.institution}, ${education.location} - ${education.year}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AchievementItem extends StatelessWidget {
  final String title;
  final String description;

  const AchievementItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.emoji_events,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
