import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/bloc/blocs.dart';

class AudioEnhancementCardWidget extends StatelessWidget {
  final bool enabled;

  const AudioEnhancementCardWidget({
    super.key,
    required this.enabled,
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
      child: Row(
        children: [
          Icon(
            Icons.graphic_eq,
            color: Colors.white.withAlpha(7),
            size: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Melhoria de Áudio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Remove ruídos e normaliza o volume',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: (value) {
              context.read<EditorBloc>().add(ToggleAudioEnhancement(value));
            },
            activeColor: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }
}
