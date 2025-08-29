import 'package:flutter/material.dart';
import 'package:video_editor/core/constants/app_colors.dart';

/// Widget para exibir status com cores e ícones apropriados
/// Usado para mostrar status de processamento, finalização, etc.
class StatusChip extends StatelessWidget {
  /// Status a ser exibido
  final String status;

  /// Texto customizado (opcional, usa o status se não fornecido)
  final String? customText;

  /// Ícone customizado (opcional, usa ícone baseado no status se não fornecido)
  final IconData? customIcon;

  /// Cor customizada (opcional, usa cor baseada no status se não fornecido)
  final Color? customColor;

  /// Tamanho do chip
  final ChipSize size;

  const StatusChip({
    super.key,
    required this.status,
    this.customText,
    this.customIcon,
    this.customColor,
    this.size = ChipSize.medium,
  });

  /// Factory constructor para status de sucesso
  factory StatusChip.success({
    Key? key,
    String text = 'Concluído',
    IconData? icon,
    ChipSize size = ChipSize.medium,
  }) {
    return StatusChip(
      key: key,
      status: 'completed',
      customText: text,
      customIcon: icon,
      customColor: AppColors.success,
      size: size,
    );
  }

  /// Factory constructor para status de erro
  factory StatusChip.error({
    Key? key,
    String text = 'Falhou',
    IconData? icon,
    ChipSize size = ChipSize.medium,
  }) {
    return StatusChip(
      key: key,
      status: 'failed',
      customText: text,
      customIcon: icon,
      customColor: AppColors.error,
      size: size,
    );
  }

  /// Factory constructor para status de processamento
  factory StatusChip.processing({
    Key? key,
    String text = 'Processando',
    IconData? icon,
    ChipSize size = ChipSize.medium,
  }) {
    return StatusChip(
      key: key,
      status: 'processing',
      customText: text,
      customIcon: icon,
      customColor: AppColors.warning,
      size: size,
    );
  }

  /// Factory constructor para status de espera
  factory StatusChip.waiting({
    Key? key,
    String text = 'Aguardando',
    IconData? icon,
    ChipSize size = ChipSize.medium,
  }) {
    return StatusChip(
      key: key,
      status: 'waiting',
      customText: text,
      customIcon: icon,
      customColor: AppColors.foregroundSecondary,
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chipData = _getChipData();
    final sizeData = _getSizeData();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sizeData.horizontalPadding,
        vertical: sizeData.verticalPadding,
      ),
      decoration: BoxDecoration(
        color: chipData.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(sizeData.borderRadius),
        border: Border.all(
          color: chipData.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            chipData.icon,
            size: sizeData.iconSize,
            color: chipData.color,
          ),
          SizedBox(width: sizeData.spacing),
          Text(
            chipData.text,
            style: TextStyle(
              color: chipData.color,
              fontSize: sizeData.fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _ChipData _getChipData() {
    if (customColor != null) {
      return _ChipData(
        color: customColor!,
        text: customText ?? status,
        icon: customIcon ?? _getDefaultIcon(),
      );
    }

    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
      case 'concluído':
        return _ChipData(
          color: AppColors.success,
          text: customText ?? 'Concluído',
          icon: customIcon ?? Icons.check_circle,
        );

      case 'processing':
      case 'processando':
      case 'loading':
        return _ChipData(
          color: AppColors.warning,
          text: customText ?? 'Processando',
          icon: customIcon ?? Icons.hourglass_empty,
        );

      case 'failed':
      case 'error':
      case 'falhou':
        return _ChipData(
          color: AppColors.error,
          text: customText ?? 'Falhou',
          icon: customIcon ?? Icons.error,
        );

      case 'waiting':
      case 'pending':
      case 'aguardando':
        return _ChipData(
          color: AppColors.foregroundSecondary,
          text: customText ?? 'Aguardando',
          icon: customIcon ?? Icons.schedule,
        );

      default:
        return _ChipData(
          color: AppColors.foregroundSecondary,
          text: customText ?? status,
          icon: customIcon ?? Icons.help,
        );
    }
  }

  IconData _getDefaultIcon() {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'success':
        return Icons.check_circle;
      case 'processing':
      case 'loading':
        return Icons.hourglass_empty;
      case 'failed':
      case 'error':
        return Icons.error;
      case 'waiting':
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

  _SizeData _getSizeData() {
    switch (size) {
      case ChipSize.small:
        return _SizeData(
          horizontalPadding: 6,
          verticalPadding: 3,
          borderRadius: 8,
          iconSize: 12,
          fontSize: 10,
          spacing: 4,
        );

      case ChipSize.medium:
        return _SizeData(
          horizontalPadding: 8,
          verticalPadding: 4,
          borderRadius: 12,
          iconSize: 14,
          fontSize: 12,
          spacing: 6,
        );

      case ChipSize.large:
        return _SizeData(
          horizontalPadding: 12,
          verticalPadding: 6,
          borderRadius: 16,
          iconSize: 16,
          fontSize: 14,
          spacing: 8,
        );
    }
  }
}

/// Enumeração para tamanhos do chip
enum ChipSize { small, medium, large }

/// Classe interna para dados do chip
class _ChipData {
  final Color color;
  final String text;
  final IconData icon;

  _ChipData({
    required this.color,
    required this.text,
    required this.icon,
  });
}

/// Classe interna para dados de tamanho
class _SizeData {
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final double iconSize;
  final double fontSize;
  final double spacing;

  _SizeData({
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
    required this.iconSize,
    required this.fontSize,
    required this.spacing,
  });
}
