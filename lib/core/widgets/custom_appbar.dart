import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;
  final ScrollController scrollController;
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onSkillsPressed;
  final VoidCallback onProjectsPressed;
  final VoidCallback onExperiencePressed;
  final VoidCallback onContactPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuTap,
    required this.scrollController,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onSkillsPressed,
    required this.onProjectsPressed,
    required this.onExperiencePressed,
    required this.onContactPressed,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrollOffset = widget.scrollController.offset;
    if (scrollOffset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (scrollOffset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 768 && size.width <= 1024;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.background.withOpacity(0.9)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [],
        backgroundBlendMode: BlendMode.overlay,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? 50
              : isTablet
                  ? 30
                  : 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Text(
              'RK',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2, end: 0),

            // Navigation
            isDesktop
                ? Row(
                    children: [
                      _buildNavItem('Home', widget.onHomePressed, 0),
                      _buildNavItem('About', widget.onAboutPressed, 1),
                      _buildNavItem('Skills', widget.onSkillsPressed, 2),
                      _buildNavItem('Projects', widget.onProjectsPressed, 3),
                      _buildNavItem(
                          'Experience', widget.onExperiencePressed, 4),
                      _buildNavItem('Contact', widget.onContactPressed, 5),
                      const SizedBox(width: 20),
                      _buildResumeButton(),
                    ],
                  )
                : IconButton(
                    onPressed: widget.onMenuTap,
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String text, VoidCallback onPressed, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textMuted,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
            duration: 800.ms, delay: Duration(milliseconds: 100 * (index + 1)))
        .slideY(begin: -0.2, end: 0);
  }

  Widget _buildResumeButton() {
    return OutlinedButton(
      onPressed: () {
        // Download resume
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text(
        'Resume',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms, delay: 600.ms)
        .slideY(begin: -0.2, end: 0);
  }
}
