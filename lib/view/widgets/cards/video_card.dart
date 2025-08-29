import 'package:flutter/material.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'package:video_editor/view/widgets/chips/status_chip.dart';

/// Widget para exibir informações de um vídeo em formato de card
/// Usado na lista de vídeos da home
class VideoCard extends StatelessWidget {
  /// Dados do vídeo a serem exibidos
  final VideoModel video;

  /// Callback para quando o card é pressionado
  final VoidCallback? onTap;

  /// Callback para ação de editar
  final VoidCallback? onEdit;

  /// Callback para ação de deletar
  final VoidCallback? onDelete;

  /// Callback para ação de compartilhar
  final VoidCallback? onShare;

  /// Se deve mostrar o menu de ações
  final bool showActions;

  /// Se deve mostrar o status
  final bool showStatus;

  /// URL da thumbnail customizada (opcional)
  final String? customThumbnail;

  const VideoCard({
    super.key,
    required this.video,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onShare,
    this.showActions = true,
    this.showStatus = true,
    this.customThumbnail,
  });

  /// Factory constructor para card simples sem ações
  factory VideoCard.simple({
    Key? key,
    required VideoModel video,
    VoidCallback? onTap,
    String? customThumbnail,
  }) {
    return VideoCard(
      key: key,
      video: video,
      onTap: onTap,
      showActions: false,
      showStatus: false,
      customThumbnail: customThumbnail,
    );
  }

  /// Factory constructor para card interativo com todas as ações
  factory VideoCard.interactive({
    Key? key,
    required VideoModel video,
    VoidCallback? onTap,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    VoidCallback? onShare,
    String? customThumbnail,
  }) {
    return VideoCard(
      key: key,
      video: video,
      onTap: onTap,
      onEdit: onEdit,
      onDelete: onDelete,
      onShare: onShare,
      showActions: true,
      showStatus: true,
      customThumbnail: customThumbnail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.foregroundSecondary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildThumbnail(),
              const SizedBox(width: 12),
              Expanded(
                child: _buildVideoInfo(),
              ),
              if (showActions) _buildActionsMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.background,
        border: Border.all(
          color: AppColors.foregroundSecondary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _buildThumbnailContent(),
      ),
    );
  }

  Widget _buildThumbnailContent() {
    final thumbnailPath = customThumbnail ?? video.thumbnailPath;

    if (thumbnailPath != null && thumbnailPath.isNotEmpty) {
      return Image.network(
        thumbnailPath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultThumbnail();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          );
        },
      );
    }

    return _buildDefaultThumbnail();
  }

  Widget _buildDefaultThumbnail() {
    return Container(
      color: AppColors.background,
      child: Icon(
        Icons.play_circle_outline,
        color: AppColors.foregroundSecondary,
        size: 24,
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          video.title,
          style: TextStyle(
            color: AppColors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        if (video.description.isNotEmpty) ...[
          Text(
            video.description,
            style: TextStyle(
              color: AppColors.foregroundSecondary,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            if (_getDuration() != null) ...[
              Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.foregroundSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                _getDuration()!,
                style: TextStyle(
                  color: AppColors.foregroundSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
            ],
            if (showStatus && _getStatus() != null) _getStatus()!,
          ],
        ),
      ],
    );
  }

  Widget _buildActionsMenu() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: AppColors.foregroundSecondary,
      ),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
            break;
          case 'share':
            onShare?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        if (onEdit != null)
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: AppColors.foreground, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Editar',
                  style: TextStyle(color: AppColors.foreground),
                ),
              ],
            ),
          ),
        if (onShare != null)
          PopupMenuItem(
            value: 'share',
            child: Row(
              children: [
                Icon(Icons.share, color: AppColors.foreground, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Compartilhar',
                  style: TextStyle(color: AppColors.foreground),
                ),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: AppColors.error, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Excluir',
                  style: TextStyle(color: AppColors.error),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String? _getDuration() {
    if (video.durationInSeconds == 0) return null;

    final duration = Duration(seconds: video.durationInSeconds);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  StatusChip? _getStatus() {
    switch (video.status) {
      case VideoStatus.completed:
        return StatusChip.success(size: ChipSize.small);

      case VideoStatus.processing:
        return StatusChip.processing(size: ChipSize.small);

      case VideoStatus.failed:
        return StatusChip.error(size: ChipSize.small);

      case VideoStatus.uploaded:
        return StatusChip.waiting(
          text: 'Enviado',
          size: ChipSize.small,
        );
    }
  }
}
