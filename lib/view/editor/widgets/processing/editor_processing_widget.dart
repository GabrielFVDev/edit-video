import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';

class EditorProcessingWidget extends StatelessWidget {
  final EditorProcessing state;

  const EditorProcessingWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              value: state.progress,
              backgroundColor: Colors.white.withAlpha(1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF6366F1),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Processando Vídeo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(state.progress * 100).toInt()}% concluído',
            style: TextStyle(
              color: Colors.white.withAlpha(7),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Aplicando jump cuts e melhorias de áudio...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
