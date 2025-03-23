import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';

class AnimatedProgressBar extends StatefulWidget {
  final double percentage;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final Duration duration;

  const AnimatedProgressBar({
    Key? key,
    required this.percentage,
    this.height = 8.0,
    this.backgroundColor = Colors.grey,
    this.foregroundColor = AppColors.primary,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentage,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percentage != widget.percentage) {
      _animation = Tween<double>(
        begin: oldWidget.percentage,
        end: widget.percentage,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.height),
          child: Container(
            height: widget.height,
            width: double.infinity,
            color: widget.backgroundColor.withOpacity(0.2),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _animation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.foregroundColor,
                        widget.foregroundColor.withOpacity(0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(widget.height),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
