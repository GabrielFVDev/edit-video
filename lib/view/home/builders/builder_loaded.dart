import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/model/models.dart';
import 'package:video_editor/view/widgets/cards/video_card.dart';
import 'package:video_editor/view/widgets/widgets.dart';

class BuilderLoaded extends StatelessWidget {
  final BuildContext context;
  final HomeLoaded state;

  const BuilderLoaded({
    super.key,
    required this.context,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
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
