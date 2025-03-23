import 'dart:math';
import 'dart:ui' as ui;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive_utils.dart';
import 'package:my_portfolio/core/widgets/animated_gradient_button.dart';
import 'package:my_portfolio/presentation/controllers/home_controller.dart';

class HomeSection extends StatefulWidget {
  final GlobalKey sectionKey;
  final VoidCallback onViewWorkPressed;

  const HomeSection({
    required this.sectionKey,
    required this.onViewWorkPressed,
  }) : super(key: sectionKey);

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with TickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenHeight = ResponsiveUtils.getScreenHeight();
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
      width: double.infinity,
      color: const Color(0xFF0A0D14),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: MinimalistNetworkPainter(
                  animation: _waveController,
                ),
              );
            },
          ),

          // Main content
          Padding(
            padding: ResponsiveUtils.getScreenPadding(context),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello, I\'m',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                            controller.name.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 40 : 60,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: isMobile ? 80 : 100,
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Flutter Developer',
                              textStyle: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: isMobile ? 30 : 40,
                                fontWeight: FontWeight.w300,
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'Mobile App Specialist',
                              textStyle: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: isMobile ? 30 : 40,
                                fontWeight: FontWeight.w300,
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'UI/UX Enthusiast',
                              textStyle: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: isMobile ? 30 : 40,
                                fontWeight: FontWeight.w300,
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Obx(() => Text(
                            controller.subtitle.value,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: isMobile ? 16 : 18,
                            ),
                          )),
                      const SizedBox(height: 40),
                      AnimatedGradientButton(
                        text: 'View My Work',
                        onPressed: widget.onViewWorkPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MinimalistNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Random _random = Random(42); // Fixed seed for consistent pattern

  // Minimalist network elements
  final List<NetworkNode> _nodes = [];
  final List<NetworkConnection> _connections = [];

  MinimalistNetworkPainter({
    required this.animation,
  }) : super(repaint: animation) {
    _initializeNetwork();
  }

  void _initializeNetwork() {
    // Create fewer nodes for minimalist effect
    for (int i = 0; i < 8; i++) {
      _nodes.add(NetworkNode(
        position: Offset(
          0.1 + _random.nextDouble() * 0.8,
          0.2 + _random.nextDouble() * 0.6,
        ),
        pulsePhase: _random.nextDouble() * 2 * pi,
        pulseSpeed: 0.3 + _random.nextDouble() * 0.3,
      ));
    }

    // Create fewer connections between nodes
    for (int i = 0; i < _nodes.length; i++) {
      for (int j = i + 1; j < _nodes.length; j++) {
        final distance = (_nodes[i].position - _nodes[j].position).distance;
        // Fewer connections for minimalist effect
        if (distance < 0.3 && _random.nextDouble() > 0.3) {
          _connections.add(NetworkConnection(
            sourceIndex: i,
            targetIndex: j,
            flowSpeed: 0.2 + _random.nextDouble() * 0.3,
            flowPhase: _random.nextDouble() * 2 * pi,
          ));
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Simple dark background
    final Paint backgroundPaint = Paint()..color = const Color(0xFF0A0D14);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Very subtle gradient overlay
    final Paint gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [
          const Color(0xFF0A0D14),
          const Color(0xFF101424),
        ],
      );
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), gradientPaint);

    // Draw connections first (behind nodes)
    for (final connection in _connections) {
      final sourceNode = _nodes[connection.sourceIndex];
      final targetNode = _nodes[connection.targetIndex];

      final sourcePos = Offset(
        sourceNode.position.dx * size.width,
        sourceNode.position.dy * size.height,
      );
      final targetPos = Offset(
        targetNode.position.dx * size.width,
        targetNode.position.dy * size.height,
      );

      // Calculate flow position based on animation
      final flowProgress =
          (animation.value * connection.flowSpeed + connection.flowPhase) % 1.0;

      // Simple, thin connection line
      final connectionPaint = Paint()
        ..color = const Color(0xFF3A6EA5).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      // Draw the connection line
      canvas.drawLine(sourcePos, targetPos, connectionPaint);

      // Draw a subtle pulse along the connection
      if (_random.nextDouble() > 0.3) {
        // Don't show pulses on all connections
        final pulsePosition = Offset.lerp(sourcePos, targetPos, flowProgress)!;
        final pulsePaint = Paint()
          ..color = const Color(0xFF4ECDC4).withOpacity(0.6)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(pulsePosition, 2, pulsePaint);
      }
    }

    // Draw minimal nodes
    for (final node in _nodes) {
      final nodePos = Offset(
        node.position.dx * size.width,
        node.position.dy * size.height,
      );

      // Very subtle pulse effect
      final pulseEffect = 0.6 +
          0.4 *
              sin(animation.value * 2 * pi * node.pulseSpeed + node.pulsePhase);

      // Simple node with minimal glow
      final nodePaint = Paint()
        ..color = const Color(0xFF4ECDC4).withOpacity(0.7 * pulseEffect)
        ..style = PaintingStyle.fill;

      // Draw small node
      canvas.drawCircle(nodePos, 3, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class NetworkNode {
  final Offset position;
  final double pulsePhase;
  final double pulseSpeed;

  NetworkNode({
    required this.position,
    required this.pulsePhase,
    required this.pulseSpeed,
  });
}

class NetworkConnection {
  final int sourceIndex;
  final int targetIndex;
  final double flowSpeed;
  final double flowPhase;

  NetworkConnection({
    required this.sourceIndex,
    required this.targetIndex,
    required this.flowSpeed,
    required this.flowPhase,
  });
}
