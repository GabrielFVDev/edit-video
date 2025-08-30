import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_player/video_player.dart';
import '../widgets.dart';

class EditorVideoPreviewWidget extends StatefulWidget {
  final EditorVideoLoaded state;
  final VideoPlayerController? videoController;

  const EditorVideoPreviewWidget({
    super.key,
    required this.state,
    required this.videoController,
  });

  @override
  State<EditorVideoPreviewWidget> createState() =>
      _EditorVideoPreviewWidgetState();
}

class _EditorVideoPreviewWidgetState extends State<EditorVideoPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child:
          widget.videoController != null &&
              widget.videoController!.value.isInitialized
          ? Stack(
              children: [
                AspectRatio(
                  aspectRatio: widget.videoController!.value.aspectRatio,
                  child: VideoPlayer(widget.videoController!),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: VideoControlsOverlay(
                    state: widget.state,
                    videoController: widget.videoController!,
                    onPlayPause: () => setState(() {}),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6366F1),
              ),
            ),
    );
  }
}
