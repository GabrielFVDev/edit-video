import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_editor/core/constants/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Mock data - será substituído por dados reais do banco
  final List<Map<String, dynamic>> _videos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Meus Vídeos',
          style: TextStyle(
            color: AppColors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implementar configurações
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.foreground,
            ),
          ),
        ],
      ),
      body: _videos.isEmpty ? _buildEmptyState() : _buildVideoList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/editor');
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.foreground,
        icon: const Icon(Icons.add),
        label: const Text('Novo Vídeo'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.video_library_outlined,
              size: 60,
              color: AppColors.foregroundDisabled,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Nenhum vídeo ainda',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comece criando seu primeiro vídeo editado',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.foregroundSecondary,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              context.go('/editor');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.foreground,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Criar Primeiro Vídeo'),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoList() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: _videos.length,
    itemBuilder: (context, index) {
      final video = _videos[index];
      return _buildVideoCard(video);
    },
  );

  Widget _buildVideoCard(Map<String, dynamic> video) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.foregroundSecondary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Thumbnail placeholder
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.play_circle_outline,
                color: AppColors.foregroundSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Video info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: const TextStyle(
                      color: AppColors.foreground,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        video['duration'],
                        style: TextStyle(
                          color: AppColors.foregroundSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          color: AppColors.foregroundSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        video['fileSize'],
                        style: TextStyle(
                          color: AppColors.foregroundSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildStatusChip(video['status']),
                      const SizedBox(width: 8),
                      Text(
                        video['createdAt'],
                        style: TextStyle(
                          color: AppColors.foregroundSecondary.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: AppColors.foregroundSecondary,
              ),
              color: AppColors.background,
              onSelected: (value) {
                _handleVideoAction(value, video);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'play',
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: AppColors.foregroundSecondary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Reproduzir',
                        style: TextStyle(color: AppColors.foreground),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: AppColors.foregroundSecondary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Editar',
                        style: TextStyle(color: AppColors.foreground),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: AppColors.foregroundSecondary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Compartilhar',
                        style: TextStyle(color: AppColors.foreground),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Excluir',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'completed':
        color = AppColors.success;
        text = 'Concluído';
        icon = Icons.check_circle;
        break;
      case 'processing':
        color = AppColors.warning;
        text = 'Processando';
        icon = Icons.hourglass_empty;
        break;
      case 'failed':
        color = AppColors.error;
        text = 'Falhou';
        icon = Icons.error;
        break;
      default:
        color = AppColors.foregroundSecondary;
        text = 'Desconhecido';
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleVideoAction(String action, Map<String, dynamic> video) {
    switch (action) {
      case 'play':
        // TODO: Implementar reprodução
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reproduzindo: ${video['title']}'),
            backgroundColor: AppColors.primary,
          ),
        );
        break;
      case 'edit':
        // TODO: Ir para editor com vídeo carregado
        context.go('/editor');
        break;
      case 'share':
        // TODO: Implementar compartilhamento
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Compartilhando: ${video['title']}'),
            backgroundColor: AppColors.primary,
          ),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(video);
        break;
    }
  }

  void _showDeleteConfirmation(Map<String, dynamic> video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Excluir vídeo',
          style: TextStyle(color: AppColors.foreground),
        ),
        content: Text(
          'Tem certeza que deseja excluir "${video['title']}"?',
          style: TextStyle(color: AppColors.foregroundSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(color: AppColors.foregroundSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implementar exclusão
              Navigator.of(context).pop();
              setState(() {
                _videos.removeWhere((v) => v['id'] == video['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${video['title']} foi excluído'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            child: const Text(
              'Excluir',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
