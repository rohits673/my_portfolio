import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

class SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const SocialButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: RotationTransition(
          turns: _rotateAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? AppColors.primary : AppColors.primary,
                width: 1.5,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : [],
            ),
            child: Icon(
              widget.icon,
              color: _isHovered ? AppColors.background : AppColors.primary,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
