import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';

import '../widgets.dart';

class EditorProcessingSettingsWidget extends StatelessWidget {
  final EditorState state;

  const EditorProcessingSettingsWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final jumpCutEnabled = state is EditorVideoLoaded
        ? (state as EditorVideoLoaded).jumpCutEnabled
        : true;
    final audioEnhancementEnabled = state is EditorVideoLoaded
        ? (state as EditorVideoLoaded).audioEnhancementEnabled
        : true;
    final jumpCutThreshold = state is EditorVideoLoaded
        ? (state as EditorVideoLoaded).jumpCutThreshold
        : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configurações de Processamento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        JumpCutSettingsCard(
          enabled: jumpCutEnabled,
          threshold: jumpCutThreshold,
        ),
        const SizedBox(height: 16),
        AudioEnhancementCardWidget(
          enabled: audioEnhancementEnabled,
        ),
      ],
    );
  }
}
