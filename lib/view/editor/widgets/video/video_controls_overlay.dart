import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_player/video_player.dart';

class VideoControlsOverlay extends StatelessWidget {
  final EditorVideoLoaded state;
  final VideoPlayerController videoController;
  final VoidCallback onPlayPause;

  const VideoControlsOverlay({
    super.key,
    required this.state,
    required this.videoController,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            state.videoModel?.title ?? 'Vídeo selecionado',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (videoController.value.isPlaying) {
                  videoController.pause();
                } else {
                  videoController.play();
                }
                onPlayPause();
              },
              icon: Icon(
                videoController.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 48,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: VideoProgressIndicator(
                videoController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Color(0xFF6366F1),
                  bufferedColor: Colors.white24,
                  backgroundColor: Colors.white12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
