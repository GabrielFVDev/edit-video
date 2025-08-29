import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  String? _selectedVideoPath;
  bool _isProcessing = false;
  double _processProgress = 0.0;

  // Configurações de processamento
  bool _jumpCutEnabled = true;
  bool _audioEnhancementEnabled = true;
  double _jumpCutThreshold = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Editor de Vídeo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_selectedVideoPath != null && !_isProcessing)
            TextButton(
              onPressed: _startProcessing,
              child: const Text(
                'PROCESSAR',
                style: TextStyle(
                  color: Color(0xFF6366F1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: _selectedVideoPath == null
          ? _buildVideoSelectionView()
          : _buildEditorView(),
    );
  }

  Widget _buildVideoSelectionView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.video_call_outlined,
                size: 60,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Selecione um vídeo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Escolha um vídeo da galeria ou grave um novo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 48),

            // Botões de seleção
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickVideoFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.video_library),
                  label: const Text(
                    'Selecionar da Galeria',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _recordNewVideo,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.videocam),
                  label: const Text(
                    'Gravar Novo Vídeo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditorView() {
    return Column(
      children: [
        // Preview do vídeo
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _isProcessing
                ? _buildProcessingView()
                : _buildVideoPreview(),
          ),
        ),

        // Configurações de processamento
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: _buildProcessingSettings(),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPreview() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.play_arrow,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Preview do Vídeo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vídeo selecionado',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              value: _processProgress,
              backgroundColor: Colors.white.withOpacity(0.1),
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
            '${(_processProgress * 100).toInt()}% concluído',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Aplicando jump cuts e melhorias de áudio...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingSettings() {
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

        // Jump Cut
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.content_cut,
                    color: Colors.white.withOpacity(0.7),
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
                    value: _jumpCutEnabled,
                    onChanged: (value) {
                      setState(() {
                        _jumpCutEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6366F1),
                  ),
                ],
              ),
              if (_jumpCutEnabled) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Sensibilidade: ${_jumpCutThreshold.toStringAsFixed(1)}s',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _jumpCutThreshold,
                  min: 0.5,
                  max: 3.0,
                  divisions: 5,
                  activeColor: const Color(0xFF6366F1),
                  inactiveColor: Colors.white.withOpacity(0.2),
                  onChanged: (value) {
                    setState(() {
                      _jumpCutThreshold = value;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Audio Enhancement
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.graphic_eq,
                color: Colors.white.withOpacity(0.7),
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
                value: _audioEnhancementEnabled,
                onChanged: (value) {
                  setState(() {
                    _audioEnhancementEnabled = value;
                  });
                },
                activeColor: const Color(0xFF6366F1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickVideoFromGallery() async {
    // TODO: Implementar seleção de vídeo com file_picker
    // Simulando seleção por enquanto
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _selectedVideoPath = '/path/to/selected/video.mp4';
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vídeo selecionado com sucesso!'),
          backgroundColor: Color(0xFF6366F1),
        ),
      );
    }
  }

  Future<void> _recordNewVideo() async {
    // TODO: Implementar gravação de vídeo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de gravação em desenvolvimento'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _startProcessing() async {
    setState(() {
      _isProcessing = true;
      _processProgress = 0.0;
    });

    // Simula processamento com progresso
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _processProgress = i / 100;
        });
      }
    }

    // Finaliza processamento
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      // Mostra resultado
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text(
            'Processamento Concluído!',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Seu vídeo foi processado com sucesso!\n\nJump cuts aplicados: ${_jumpCutEnabled ? "Sim" : "Não"}\nMelhoria de áudio: ${_audioEnhancementEnabled ? "Sim" : "Não"}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/home');
              },
              child: const Text(
                'Voltar ao Início',
                style: TextStyle(color: Color(0xFF6366F1)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implementar exportação/compartilhamento
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
              ),
              child: const Text('Exportar'),
            ),
          ],
        ),
      );
    }
  }
}
