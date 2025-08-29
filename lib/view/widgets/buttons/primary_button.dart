import 'package:flutter/material.dart';
import '../loading/custom_loading.dart';

enum ButtonState { normal, loading, disabled, error }

class PrimaryButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double radius;
  final void Function()? onPressed;
  final ButtonState state;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final IconData? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? loadingIndicatorSize;
  final LoadingType loadingType;

  const PrimaryButton({
    super.key,
    required this.label,
    this.radius = 12.0,
    this.onPressed,
    this.backgroundColor = const Color(0xFF6366F1),
    this.foregroundColor = Colors.white,
    this.state = ButtonState.normal,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.elevation = 0,
    this.icon,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.loadingIndicatorSize = 20,
    this.loadingType = LoadingType.circular,
  });

  // Construtor para botão com ícone
  const PrimaryButton.icon({
    super.key,
    required this.label,
    required this.icon,
    this.radius = 12.0,
    this.onPressed,
    this.backgroundColor = const Color(0xFF6366F1),
    this.foregroundColor = Colors.white,
    this.state = ButtonState.normal,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.elevation = 0,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.loadingIndicatorSize = 20,
    this.loadingType = LoadingType.circular,
  });

  // Construtor para botão secundário/outline
  const PrimaryButton.outline({
    super.key,
    required this.label,
    this.radius = 12.0,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor = Colors.white,
    this.state = ButtonState.normal,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.elevation = 0,
    this.icon,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.loadingIndicatorSize = 20,
    this.loadingType = LoadingType.dots,
  });

  @override
  Widget build(BuildContext context) {
    Color? effectiveBackgroundColor = backgroundColor;
    Color? effectiveForegroundColor = foregroundColor;

    final bool isDisabled;

    if (state == ButtonState.disabled ||
        state == ButtonState.loading ||
        onPressed == null) {
      isDisabled = true;
    } else {
      isDisabled = false;
    }

    switch (state) {
      case ButtonState.error:
        effectiveBackgroundColor = Colors.red.shade600;
        effectiveForegroundColor = Colors.white;
        break;
      case ButtonState.disabled:
        effectiveBackgroundColor = backgroundColor?.withAlpha(100);
        effectiveForegroundColor = foregroundColor?.withAlpha(150);
        break;
      case ButtonState.loading:
      case ButtonState.normal:
        // Mantém as cores originais
        break;
    }

    // Se é um botão outline
    if (backgroundColor == Colors.transparent) {
      return OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveForegroundColor,
          side: BorderSide(
            color: (effectiveForegroundColor ?? Colors.white).withAlpha(75),
          ),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: elevation,
        ),
        child: _buildChild(),
      );
    }

    // Botão normal com ícone
    if (icon != null && state != ButtonState.loading) {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: elevation,
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      );
    }

    // Botão normal
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: elevation,
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    switch (state) {
      case ButtonState.loading:
        return SizedBox(
          height: loadingIndicatorSize,
          width:
              loadingType == LoadingType.dots ||
                  loadingType == LoadingType.bounce
              ? loadingIndicatorSize! * 2
              : loadingIndicatorSize,
          child: CustomLoading(
            size: loadingIndicatorSize!,
            color: foregroundColor ?? Colors.white,
            type: loadingType,
            strokeWidth: 2,
          ),
        );

      case ButtonState.error:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        );

      case ButtonState.normal:
      case ButtonState.disabled:
        return Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );
    }
  }
}
