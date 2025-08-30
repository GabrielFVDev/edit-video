import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_player/video_player.dart';
import '../widgets.dart';

class EditorVideoLoadedWidget extends StatelessWidget {
  final EditorState state;
  final VideoPlayerController? videoController;

  const EditorVideoLoadedWidget({
    super.key,
    required this.state,
    required this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Preview do vídeo
          Container(
            height: MediaQuery.of(context).size.height * 0.4, // 40% da tela
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: state is EditorProcessing
                ? EditorProcessingWidget(state: state as EditorProcessing)
                : EditorVideoPreviewWidget(
                    state: state as EditorVideoLoaded,
                    videoController: videoController,
                  ),
          ),
          // Configurações de processamento
          Container(
            padding: const EdgeInsets.all(16),
            child: EditorProcessingSettingsWidget(state: state),
          ),
          // Adicionar espaço extra no final para garantir scroll
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class JumpCutSettingsCard extends StatelessWidget {
  final bool enabled;
  final double threshold;

  const JumpCutSettingsCard({
    super.key,
    required this.enabled,
    required this.threshold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withAlpha(1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.content_cut,
                color: Colors.white.withAlpha(7),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Jump Cut Automático',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Switch(
                value: enabled,
                onChanged: (value) {
                  context.read<EditorBloc>().add(ToggleJumpCut(value));
                },
                activeColor: const Color(0xFF6366F1),
              ),
            ],
          ),
          if (enabled) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Sensibilidade: ${threshold.toStringAsFixed(1)}s',
                  style: TextStyle(
                    color: Colors.white.withAlpha(7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Slider(
              value: threshold,
              min: 0.5,
              max: 3.0,
              divisions: 5,
              activeColor: const Color(0xFF6366F1),
              inactiveColor: Colors.white.withAlpha(2),
              onChanged: (value) {
                context.read<EditorBloc>().add(SetJumpCutThreshold(value));
              },
            ),
          ],
        ],
      ),
    );
  }
}
