import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

class AnimatedGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const AnimatedGradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.gradient = AppColors.primaryGradient,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  _AnimatedGradientButtonState createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
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
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.gradient.colors.first.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
