import 'package:flutter/material.dart';

/// Classe que centraliza todas as cores utilizadas no aplicativo
/// Baseada no design system atual do projeto
class AppColors {
  // ========== CORES PRINCIPAIS ==========

  /// Cor de fundo principal da aplicação
  static const Color background = Color(0xFF1A1A1A);

  /// Cor de superfície secundária (cards, inputs, etc)
  static const Color surface = Color(0xFF2A2A2A);

  /// Cor do texto principal
  static const Color foreground = Color(0xFFFFFFFF);

  /// Cor do texto secundário (subtítulos, placeholders)
  static const Color foregroundSecondary = Color(
    0xB3FFFFFF,
  ); // white.withOpacity(0.7)

  /// Cor do texto desabilitado
  static const Color foregroundDisabled = Color(
    0x0DFFFFFF,
  ); // white.withAlpha(5)

  // ========== CORES DE IDENTIDADE ==========

  /// Cor primária roxa do aplicativo
  static const Color primary = Color(0xFF9959FF); // 153, 89, 255

  /// Cor secundária roxa/pink
  static const Color secondary = Color(0xFFCF33FF); // 207, 51, 255

  /// Cor de accent (botões primários)
  static const Color accent = Color(0xFF6366F1);

  // ========== CORES DE ESTADO ==========

  /// Cor de sucesso
  static const Color success = Color(0xFF22C55E); // 34, 197, 94

  /// Cor de aviso/warning
  static const Color warning = Color(0xFFFFBF36); // 255, 191, 54

  /// Cor de erro
  static const Color error = Color(0xFFFF0073);

  /// Cor de erro padrão
  static const Color errorDefault = Color(0xFFB00020);

  // ========== CORES ESPECÍFICAS DO VÍDEO ==========

  /// Cor primária para elementos de vídeo
  static const Color videoPrimary = primary;

  /// Cor secundária para elementos de vídeo
  static const Color videoSecondary = secondary;

  /// Cor de sucesso para processamento de vídeo
  static const Color videoSuccess = success;

  /// Cor de warning para processamento de vídeo
  static const Color videoWarning = warning;

  /// Cor da timeline de vídeo
  static const Color videoTimeline = Color(0xFF202638); // 32, 38, 56

  // ========== CORES DE BOTÃO ==========

  /// Cor primária para botões (roxa suave)
  static const Color buttonPrimary = primary; // Usa a cor primária roxa

  /// Cor secundária para botões (roxa mais suave)
  static const Color buttonSecondary = Color(0xFF8B5FBF); // Roxa mais suave

  /// Cor padrão de botão (estado normal) - roxa suave
  static const Color buttonNormal = Color(0xFF7C3AED); // Roxa suave para botões

  /// Cor de botão desabilitado
  static const Color buttonDisabled = Color(0xFFB6B6B6);

  /// Cor de botão em estado de erro
  static const Color buttonError = error;

  // ========== CORES COMPLEMENTARES ==========

  /// Cor para texto em superfícies primárias
  static const Color onPrimary = foreground;

  /// Cor para texto em superfícies de fundo
  static const Color onBackground = foreground;

  /// Cor para texto em superfícies de accent
  static const Color onAccent = foreground;

  /// Cor para texto em superfícies de sucesso
  static const Color onSuccess = foreground;

  /// Cor para texto em superfícies de erro
  static const Color onError = foreground;

  /// Cor transparente
  static const Color transparent = Colors.transparent;

  // ========== GRADIENTES ==========

  /// Gradiente principal do aplicativo
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradiente para botões
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [accent, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ========== OPACIDADES COMUNS ==========

  /// Opacidade para elementos desabilitados
  static const double disabledOpacity = 0.5;

  /// Opacidade para elementos secundários
  static const double secondaryOpacity = 0.7;

  /// Opacidade para overlays
  static const double overlayOpacity = 0.8;

  /// Opacidade para sombras
  static const double shadowOpacity = 0.2;
}

/// Extensão para facilitar o uso de cores com opacidade
extension AppColorsExtension on Color {
  /// Retorna a cor com opacidade secundária
  Color get withSecondaryOpacity => withOpacity(AppColors.secondaryOpacity);

  /// Retorna a cor com opacidade de desabilitado
  Color get withDisabledOpacity => withOpacity(AppColors.disabledOpacity);

  /// Retorna a cor com opacidade de overlay
  Color get withOverlayOpacity => withOpacity(AppColors.overlayOpacity);

  /// Retorna a cor com opacidade de sombra
  Color get withShadowOpacity => withOpacity(AppColors.shadowOpacity);
}
