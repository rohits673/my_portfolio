import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onContactPressed;

  const CustomDrawer({
    super.key,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onSkillsPressed,
    required this.onProjectsPressed,
    required this.onExperiencePressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Navigation items
            _buildNavItem(context, 'Home', onHomePressed),
            _buildNavItem(context, 'About', onAboutPressed),
            _buildNavItem(context, 'Skills', onSkillsPressed),
            _buildNavItem(context, 'Projects', onProjectsPressed),
            _buildNavItem(context, 'Experience', onExperiencePressed),
            _buildNavItem(context, 'Contact', onContactPressed),

            const SizedBox(height: 30),

            // Resume button
            OutlinedButton(
              onPressed: () {
                // Download resume
              },
              child: const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Spacer(),

            // Social links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(
                    Icons.mail,
                    () =>
                        launchUrl(Uri.parse('mailto:Rohit673.mail@gmail.com'))),
                const SizedBox(width: 20),
                _buildSocialIcon(
                    Icons.code,
                    () => launchUrl(
                        Uri.parse('https://github.com/yourusername'))),
                const SizedBox(width: 20),
                _buildSocialIcon(
                    Icons.link,
                    () => launchUrl(Uri.parse(
                        'https://www.linkedin.com/in/rohit-kumar673/'))),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textMuted,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }
}
