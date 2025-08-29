import 'package:flutter/material.dart';

enum ButtonState { normal, loading, disabled, error }

class PrimaryButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double radius;
  final void Function()? onPressed;
  final ButtonState state;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.radius,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF6366F1),
    this.foregroundColor = Colors.white,
    this.state = ButtonState.normal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(label),
    );
  }
}
