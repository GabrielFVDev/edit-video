import 'package:flutter/material.dart';
import 'package:video_editor/view/widgets/loading/custom_loading.dart';

/// Enum representing the possible states of [PrimaryButton]
enum StateButton {
  /// Normal active state
  success,

  /// Loading state (shows a loading indicator)
  loading,

  /// Error state (shows error styling)
  error,

  /// Disabled state
  disabled,
}

class PrimaryButton extends StatelessWidget {
  final String label;

  /// Callback function when the button is pressed
  final VoidCallback onPressed;

  /// Border radius of the button
  final BorderRadiusGeometry? borderRadius;

  /// Background color of the button
  final Color color;

  /// Width of the button
  final double width;

  /// Height of the button
  final double height;

  /// Optional icon to display alongside the text
  final IconData? icon;

  /// Current state of the button
  final StateButton state;

  /// Color of the button's border
  final Color borderColor;

  /// Internal factory name used for styling
  final String _factoryName;

  /// Private main constructor
  const PrimaryButton._({
    required this.label,
    required this.onPressed,
    this.state = StateButton.success,
    this.borderRadius,
    this.color = const Color(0xFF111111),
    this.width = 327,
    this.height = 48,
    this.icon,
    this.borderColor = Colors.transparent,
    required String factoryName,
  }) : _factoryName = factoryName;

  /// Creates a square button with an outline border
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to transparent)
  /// - [width]: Button width (defaults to full width)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.outlinedSquare({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = const Color(0xFF111111),
    double width = double.infinity,
    double height = 48,
    IconData? icon,
    BorderRadiusGeometry? borderRadius,
  }) {
    return PrimaryButton._outlined(
      key: key,
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
    );
  }

  /// Creates a rounded button with an outline border
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to transparent)
  /// - [borderColor]: Border color (defaults to black)
  /// - [width]: Button width (defaults to full width)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.outlinedRounded({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = Colors.transparent,
    Color borderColor = const Color(0xFF111111),
    double width = double.infinity,
    double height = 48,
    IconData? icon,
    BorderRadiusGeometry? borderRadius,
  }) {
    return PrimaryButton._outlined(
      key: key,
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(height * 0.5),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: borderColor,
    );
  }

  /// Creates a text-only button with no background or border
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to transparent)
  /// - [width]: Button width (defaults to full width)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.onlyText({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = Colors.transparent,
    double width = double.infinity,
    BorderRadiusGeometry? borderRadius,
    double height = 48,
    IconData? icon,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.zero,
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
      factoryName: 'onlyText',
    );
  }

  /// Creates a square button with solid background
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to black)
  /// - [width]: Button width (defaults to full width)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.square({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = const Color(0xFF111111),
    double width = double.infinity,
    double height = 48,
    BorderRadiusGeometry? borderRadius,
    IconData? icon,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
      factoryName: 'square',
    );
  }

  /// Creates a fully rounded button with solid background
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to black)
  /// - [width]: Button width (defaults to full width)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.bigRounded({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = const Color(0xFF111111),
    double width = double.infinity,
    double height = 48,
    IconData? icon,
    BorderRadiusGeometry? borderRadius,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(height * 0.5),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
      factoryName: 'bigRounded',
    );
  }

  /// Creates a small rounded button with solid background
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to black)
  /// - [width]: Button width (defaults to 87)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.smallRounded({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = const Color(0xFF111111),
    double width = 87,
    double height = 48,
    IconData? icon,
    BorderRadiusGeometry? borderRadius,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(height * 0.5),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
      factoryName: 'smallRounded',
    );
  }

  /// Creates a small square button with solid background
  ///
  /// - [label]: The button text
  /// - [onPressed]: Callback when pressed
  /// - [state]: Button state (defaults to [StateButton.success])
  /// - [color]: Background color (defaults to black)
  /// - [width]: Button width (defaults to 87)
  /// - [height]: Button height (defaults to 48)
  /// - [icon]: Optional icon to display
  factory PrimaryButton.smallSquare({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    StateButton state = StateButton.success,
    Color color = const Color(0xFF111111),
    double width = 87,
    double height = 48,
    IconData? icon,
    BorderRadiusGeometry? borderRadius,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: color,
      factoryName: 'smallSquare',
    );
  }

  /// Private factory for outlined buttons
  factory PrimaryButton._outlined({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    required StateButton state,
    required BorderRadiusGeometry borderRadius,
    required double width,
    required double height,
    Color borderColor = const Color(0xFF111111),
    Color color = Colors.transparent,
    IconData? icon,
  }) {
    return PrimaryButton._(
      label: label,
      onPressed: onPressed,
      state: state,
      borderRadius: borderRadius,
      color: color,
      width: width,
      height: height,
      icon: icon,
      borderColor: borderColor,
      factoryName: 'outlined',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    BorderRadiusGeometry border = BorderRadius.zero;

    /// Gets the background color based on the button state and style
    Color getColorState(StateButton state) {
      if (_factoryName == 'onlyText' || _factoryName == 'outlined') {
        return Colors.transparent;
      }

      return switch (state) {
        StateButton.success => const Color(0xFF111111),
        StateButton.disabled => const Color(0xFFB6B6B6),
        StateButton.error => const Color(0xFFFF0073),
        StateButton.loading => color,
      };
    }

    /// Gets the border color based on the button state and style
    Color getColorBorder(StateButton state) {
      if (_factoryName == 'onlyText') {
        return Colors.transparent;
      }

      return switch (state) {
        StateButton.success => const Color(0xFF111111),
        StateButton.disabled => const Color(0xFFB6B6B6),
        StateButton.error => const Color(0xFFFF0073),
        StateButton.loading => Colors.transparent,
      };
    }

    /// Gets the text color based on the button state and style
    Color getColorText(StateButton state) {
      if (_factoryName == 'onlyText' || _factoryName == 'outlined') {
        return switch (state) {
          StateButton.success => const Color(0xFF111111),
          StateButton.disabled => const Color(0xFF717171),
          StateButton.error => const Color(0xFFFF0073),
          StateButton.loading => const Color(0xFF111111),
        };
      }

      return switch (state) {
        StateButton.success => Colors.white,
        StateButton.disabled => const Color(0xFF717171),
        StateButton.error => Colors.white,
        StateButton.loading => Colors.white,
      };
    }

    /// Builds the appropriate content widget based on the button state
    Widget getContent(StateButton state) {
      TextAlign textAlignment = TextAlign.left;

      // Determine text alignment based on button style
      if (_factoryName == 'bigRounded') {
        textAlignment = TextAlign.center;
      } else if (_factoryName == 'smallRounded' ||
          _factoryName == 'smallSquare') {
        textAlignment = TextAlign.left;
      } else {
        textAlignment = TextAlign.center;
      }

      return switch (state) {
        StateButton.success => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null &&
                _factoryName != "smallRounded" &&
                _factoryName != "smallSquare")
              const SizedBox(width: 24.0),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                textAlign: textAlignment,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                  color: getColorText(state),
                ),
              ),
            ),
            if (icon != null) Icon(icon, color: getColorText(state)),
          ],
        ),
        StateButton.disabled => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null &&
                _factoryName != "smallRounded" &&
                _factoryName != "smallSquare")
              const SizedBox(width: 24.0),
            Expanded(
              child: Text(
                label,
                textAlign: textAlignment,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                  color: getColorText(state),
                ),
              ),
            ),
            if (icon != null) Icon(icon, color: getColorText(state)),
          ],
        ),
        StateButton.error => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null &&
                _factoryName != "smallRounded" &&
                _factoryName != "smallSquare")
              const SizedBox(width: 24.0),
            Expanded(
              child: Text(
                label,
                textAlign: textAlignment,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                  color: getColorText(state),
                ),
              ),
            ),
            if (icon != null) Icon(icon, color: getColorText(state)),
          ],
        ),
        StateButton.loading => Center(
          child: CustomLoading(
            strokeWidth: 3,
            color: colorScheme.primaryContainer,
          ),
        ),
      };
    }

    // Set border radius based on provided value or default
    if (borderRadius != null) {
      border = borderRadius!;
    } else {
      border = BorderRadius.circular(height * 0.16);
    }

    // Determine if button should be clickable
    void Function()? onClick;
    if (state == StateButton.disabled || state == StateButton.loading) {
      onClick = null;
    } else {
      onClick = onPressed.call;
    }

    // Set elevation for flat-style buttons
    double? elevationValue;
    if (_factoryName == "onlyText" || _factoryName == "outlined") {
      elevationValue = 0.0;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          disabledBackgroundColor: getColorState(state),
          backgroundColor: getColorState(state),
          elevation: elevationValue,
          shape: RoundedRectangleBorder(
            borderRadius: border,
            side: BorderSide(color: getColorBorder(state)),
          ),
        ),
        onPressed: onClick,
        child: getContent(state),
      ),
    );
  }
}
