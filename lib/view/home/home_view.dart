import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'package:video_editor/view/widgets/widgets.dart';
import 'package:video_editor/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          // Botão para simular erro (apenas para demonstração)
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).simulateError();
            },
            icon: const Icon(
              Icons.bug_report,
              color: AppColors.error,
            ),
          ),
        ],
      ),
      body: StateBuilder<List<VideoModel>>(
        state: homeState,
        emptyTitle: 'Nenhum vídeo ainda',
        emptySubtitle: 'Comece criando seu primeiro vídeo editado',
        emptyIcon: Icons.video_library_outlined,
        emptyAction: () => context.go('/editor'),
        emptyActionText: 'Criar Primeiro Vídeo',
        contentBuilder: (context, videos) =>
            _buildVideoList(context, ref, videos),
        errorBuilder: (context, error) => _buildErrorState(context, ref, error),
      ),
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

  Widget _buildVideoList(
    BuildContext context,
    WidgetRef ref,
    List<VideoModel> videos,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoCard.interactive(
          video: video,
          onTap: () {
            // TODO: Implementar visualização do vídeo
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Reproduzindo: ${video.title}'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
          onEdit: () {
            // TODO: Implementar edição do vídeo
            context.go('/editor');
          },
          onShare: () {
            // TODO: Implementar compartilhamento
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Compartilhando: ${video.title}'),
                backgroundColor: AppColors.primary,
              ),
            );
          },
          onDelete: () {
            _handleDeleteVideo(context, ref, video);
          },
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ops! Algo deu errado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.foregroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).clearError();
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
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDeleteVideo(
    BuildContext context,
    WidgetRef ref,
    VideoModel video,
  ) {
    GenericDeleteDialog.showVideoDialog(
      context: context,
      videoTitle: video.title,
      onConfirmDelete: () {
        // Remove o vídeo usando o ViewModel
        ref.read(homeViewModelProvider.notifier).removeVideo(video.id);

        // Mostrar feedback de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${video.title} foi excluído'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            action: SnackBarAction(
              label: 'Desfazer',
              textColor: AppColors.foreground,
              onPressed: () {
                // Adiciona o vídeo de volta usando o ViewModel
                ref.read(homeViewModelProvider.notifier).addVideo(video);
              },
            ),
          ),
        );
      },
    );
  }
}
