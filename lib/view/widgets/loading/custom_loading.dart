import 'package:flutter/material.dart';

enum LoadingType { circular, dots, pulse, bounce }

class CustomLoading extends StatefulWidget {
  final double size;
  final Color color;
  final LoadingType type;
  final double strokeWidth;

  const CustomLoading({
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.type = LoadingType.circular,
    this.strokeWidth = 2,
  });

  // Loading específico para botões
  const CustomLoading.button({
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.type = LoadingType.circular,
    this.strokeWidth = 2,
  });

  // Loading com pontos animados
  const CustomLoading.dots({
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.type = LoadingType.dots,
    this.strokeWidth = 2,
  });

  // Loading com efeito pulse
  const CustomLoading.pulse({
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.type = LoadingType.pulse,
    this.strokeWidth = 2,
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation =
        Tween<double>(
          begin: 0.8,
          end: 1.2,
        ).animate(
          CurvedAnimation(
            parent: _pulseController,
            curve: Curves.easeInOut,
          ),
        );

    _startAnimation();
  }

  void _startAnimation() {
    switch (widget.type) {
      case LoadingType.circular:
        _controller.repeat();
        break;
      case LoadingType.dots:
        _controller.repeat();
        break;
      case LoadingType.pulse:
        _pulseController.repeat(reverse: true);
        break;
      case LoadingType.bounce:
        _controller.repeat(reverse: true);
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case LoadingType.circular:
        return _buildCircularLoading();
      case LoadingType.dots:
        return _buildDotsLoading();
      case LoadingType.pulse:
        return _buildPulseLoading();
      case LoadingType.bounce:
        return _buildBounceLoading();
    }
  }

  Widget _buildCircularLoading() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
      ),
    );
  }

  Widget _buildDotsLoading() {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final delay = index * 0.2;
              final progress = (_controller.value + delay) % 1.0;
              final opacity = (1.0 - (progress - 0.5).abs() * 2).clamp(
                0.3,
                1.0,
              );

              return Container(
                width: widget.size * 0.2,
                height: widget.size * 0.2,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(opacity),
                  shape: BoxShape.circle,
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildPulseLoading() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBounceLoading() {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final delay = index * 0.2;
              final progress = (_controller.value + delay) % 1.0;
              final translateY =
                  -(widget.size * 0.3 * (1.0 - (progress - 0.5).abs() * 2))
                      .clamp(0.0, widget.size * 0.3);

              return Transform.translate(
                offset: Offset(0, translateY),
                child: Container(
                  width: widget.size * 0.25,
                  height: widget.size * 0.25,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
