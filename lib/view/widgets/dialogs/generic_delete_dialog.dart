import 'package:flutter/material.dart';
import 'package:video_editor/core/constants/app_colors.dart';

/// Widget genérico para confirmação de exclusão
/// Pode ser usado para diferentes tipos de items (vídeos, projetos, etc.)
class GenericDeleteDialog extends StatelessWidget {
  /// Título do item a ser excluído
  final String itemTitle;

  /// Tipo do item (ex: "vídeo", "projeto", "arquivo")
  final String itemType;

  /// Callback executado quando confirmada a exclusão
  final VoidCallback onConfirmDelete;

  /// Título customizado do dialog (opcional)
  final String? customTitle;

  /// Mensagem customizada do dialog (opcional)
  final String? customMessage;

  /// Texto do botão de confirmação (opcional, padrão: "Excluir")
  final String? confirmButtonText;

  /// Texto do botão de cancelamento (opcional, padrão: "Cancelar")
  final String? cancelButtonText;

  const GenericDeleteDialog({
    super.key,
    required this.itemTitle,
    required this.itemType,
    required this.onConfirmDelete,
    this.customTitle,
    this.customMessage,
    this.confirmButtonText,
    this.cancelButtonText,
  });

  /// Factory constructor específico para vídeos
  factory GenericDeleteDialog.video({
    Key? key,
    required String videoTitle,
    required VoidCallback onConfirmDelete,
  }) {
    return GenericDeleteDialog(
      key: key,
      itemTitle: videoTitle,
      itemType: 'vídeo',
      onConfirmDelete: onConfirmDelete,
    );
  }

  /// Factory constructor específico para projetos
  factory GenericDeleteDialog.project({
    Key? key,
    required String projectTitle,
    required VoidCallback onConfirmDelete,
  }) {
    return GenericDeleteDialog(
      key: key,
      itemTitle: projectTitle,
      itemType: 'projeto',
      onConfirmDelete: onConfirmDelete,
    );
  }

  /// Factory constructor específico para arquivos
  factory GenericDeleteDialog.file({
    Key? key,
    required String fileName,
    required VoidCallback onConfirmDelete,
  }) {
    return GenericDeleteDialog(
      key: key,
      itemTitle: fileName,
      itemType: 'arquivo',
      onConfirmDelete: onConfirmDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        customTitle ?? 'Excluir $itemType',
        style: const TextStyle(
          color: AppColors.foreground,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customMessage ?? 'Tem certeza que deseja excluir "$itemTitle"?',
            style: const TextStyle(
              color: AppColors.foregroundSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.withAlpha(1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.error.withAlpha(3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Esta ação não pode ser desfeita.',
                    style: TextStyle(
                      color: AppColors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Botão Cancelar
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            cancelButtonText ?? 'Cancelar',
            style: const TextStyle(
              color: AppColors.foregroundSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Botão Excluir
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirmDelete();
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.error,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            confirmButtonText ?? 'Excluir',
            style: const TextStyle(
              color: AppColors.onError,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Método estático para mostrar o dialog
  static Future<bool?> show({
    required BuildContext context,
    required String itemTitle,
    required String itemType,
    required VoidCallback onConfirmDelete,
    String? customTitle,
    String? customMessage,
    String? confirmButtonText,
    String? cancelButtonText,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => GenericDeleteDialog(
        itemTitle: itemTitle,
        itemType: itemType,
        onConfirmDelete: onConfirmDelete,
        customTitle: customTitle,
        customMessage: customMessage,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
      ),
    );
  }

  /// Método estático específico para vídeos
  static Future<bool?> showVideoDialog({
    required BuildContext context,
    required String videoTitle,
    required VoidCallback onConfirmDelete,
  }) {
    return show(
      context: context,
      itemTitle: videoTitle,
      itemType: 'vídeo',
      onConfirmDelete: onConfirmDelete,
    );
  }

  /// Método estático específico para projetos
  static Future<bool?> showProjectDialog({
    required BuildContext context,
    required String projectTitle,
    required VoidCallback onConfirmDelete,
  }) {
    return show(
      context: context,
      itemTitle: projectTitle,
      itemType: 'projeto',
      onConfirmDelete: onConfirmDelete,
    );
  }

  /// Método estático específico para arquivos
  static Future<bool?> showFileDialog({
    required BuildContext context,
    required String fileName,
    required VoidCallback onConfirmDelete,
  }) {
    return show(
      context: context,
      itemTitle: fileName,
      itemType: 'arquivo',
      onConfirmDelete: onConfirmDelete,
    );
  }
}

/// Exemplos de uso:
/// 
/// ```dart
/// // Uso básico com método estático para vídeos
/// GenericDeleteDialog.showVideoDialog(
///   context: context,
///   videoTitle: 'Meu Vídeo.mp4',
///   onConfirmDelete: () {
///     // Lógica de exclusão aqui
///     print('Vídeo excluído');
///   },
/// );
/// 
/// // Uso avançado com customização
/// GenericDeleteDialog.show(
///   context: context,
///   itemTitle: 'Documento importante',
///   itemType: 'documento',
///   customTitle: 'Excluir documento permanentemente?',
///   customMessage: 'Este documento contém informações importantes.',
///   confirmButtonText: 'Sim, excluir',
///   cancelButtonText: 'Não, manter',
///   onConfirmDelete: () {
///     // Lógica de exclusão personalizada
///   },
/// );
/// 
/// // Uso com widget direto
/// showDialog(
///   context: context,
///   builder: (context) => GenericDeleteDialog.video(
///     videoTitle: 'Meu Vídeo.mp4',
///     onConfirmDelete: () {
///       // Lógica de exclusão
///     },
///   ),
/// );
/// 
/// // Uso para diferentes tipos
/// GenericDeleteDialog.showProjectDialog(...);  // Para projetos
/// GenericDeleteDialog.showFileDialog(...);     // Para arquivos
/// ```
