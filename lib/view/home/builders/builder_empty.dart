import 'package:flutter/material.dart';
import 'package:video_editor/core/constants/app_colors.dart';

class BuilderEmpty extends StatelessWidget {
  const BuilderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no botão + para adicionar seu primeiro vídeo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
