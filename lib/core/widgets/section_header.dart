import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool centered;
  final double? width;

  const SectionHeader({
    Key? key,
    required this.title,
    this.centered = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: width ?? (centered ? 100 : double.infinity),
          height: 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.primary,
                Color(0xFF48A999),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
