import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void _showDeleteConfirmation(Map<String, dynamic> video) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text(
        'Excluir vídeo',
        style: TextStyle(color: AppColors.foreground),
      ),
      content: Text(
        'Tem certeza que deseja excluir "${video['title']}"?',
        style: TextStyle(color: AppColors.foregroundSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(color: AppColors.foregroundSecondary),
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Implementar exclusão
            Navigator.of(context).pop();
            setState(() {
              _videos.removeWhere((v) => v['id'] == video['id']);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${video['title']} foi excluído'),
                backgroundColor: AppColors.error,
              ),
            );
          },
          child: const Text(
            'Excluir',
            style: TextStyle(color: AppColors.error),
          ),
        ),
      ],
    ),
  );
}
