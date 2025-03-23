import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/section_header.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({
    required this.sectionKey,
  }) : super(key: sectionKey);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: ResponsiveUtils.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          isMobile
              ? _buildMobileLayout(controller)
              : _buildDesktopLayout(controller),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(HomeController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.aboutParagraphs.map((paragraph) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      paragraph,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 400,
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.surfaceGradient,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Image.asset(
              "assets/images/my_image.png",
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.only(top: 30),
          margin: const EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.surfaceGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              "assets/images/my_image.png",
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        ...controller.aboutParagraphs.map((paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                paragraph,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            )),
      ],
    );
  }
}
