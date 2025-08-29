import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'package:video_editor/view/widgets/widgets.dart';
import 'package:video_editor/bloc/blocs.dart';

class HomeViewBLoC extends StatefulWidget {
  const HomeViewBLoC({super.key});

  @override
  State<HomeViewBLoC> createState() => _HomeViewBLoCState();
}

class _HomeViewBLoCState extends State<HomeViewBLoC> {
  @override
  void initState() {
    super.initState();
    // Carregar vídeos na inicialização
    context.read<HomeBloc>().add(const LoadVideos());
  }

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
              context.read<HomeBloc>().add(const SimulateError());
            },
            icon: const Icon(
              Icons.bug_report,
              color: AppColors.error,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is HomeError) {
            return _buildErrorState(context, state);
          }

          if (state is HomeEmpty) {
            return _buildEmptyState(context);
          }

          if (state is HomeLoaded) {
            return _buildLoadedState(context, state);
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/editor'),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, HomeError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar vídeos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.foreground.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.foreground.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(const ClearError());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.video_library_outlined,
            size: 64,
            color: AppColors.foregroundSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum vídeo encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.foreground.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no botão + para adicionar seu primeiro vídeo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.foreground.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, HomeLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(const RefreshVideos());
      },
      color: AppColors.primary,
      child: Column(
        children: [
          if (state.isRefreshing)
            const LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                final video = state.videos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VideoCard(
                    video: video,
                    onTap: () => context.push('/editor', extra: video),
                    onDelete: () => _showDeleteDialog(context, video),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, VideoModel video) {
    showDialog(
      context: context,
      builder: (context) => GenericDeleteDialog(
        itemTitle: video.title,
        itemType: 'vídeo',
        onConfirmDelete: () {
          context.read<HomeBloc>().add(RemoveVideo(video.id));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
