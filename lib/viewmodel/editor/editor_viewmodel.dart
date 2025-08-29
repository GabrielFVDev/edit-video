import 'package:video_editor/states/states.dart';
import '../../model/models.dart';

class EditorViewModel extends StateNotifier<EditorState> {
  EditorViewModel() : super(const EditorState());

  // Seleciona vídeo da galeria
  Future<void> selectVideoFromGallery() async {
    try {
      // TODO: Implementar file_picker
      // Simulando seleção por enquanto
      await Future.delayed(const Duration(milliseconds: 500));

      final videoPath = '/mock/path/to/selected/video.mp4';

      // Cria VideoModel temporário
      final video = VideoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Vídeo Selecionado',
        description: 'Vídeo para edição',
        originalPath: videoPath,
        status: VideoStatus.uploaded,
        createdAt: DateTime.now(),
        durationInSeconds: 180, // Mock: 3 minutos
        fileSizeInBytes: 25165824, // Mock: ~24MB
        userId: 'user1',
      );

      state = state.copyWith(
        selectedVideoPath: videoPath,
        currentVideo: video,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Erro ao selecionar vídeo: ${e.toString()}',
      );
    }
  }

  // Grava novo vídeo
  Future<void> recordNewVideo() async {
    // TODO: Implementar gravação de vídeo
    state = state.copyWith(
      error: 'Funcionalidade de gravação em desenvolvimento',
    );
  }

  // Inicia processamento
  Future<void> startProcessing() async {
    if (state.currentVideo == null) {
      state = state.copyWith(error: 'Nenhum vídeo selecionado');
      return;
    }

    state = state.copyWith(
      isProcessing: true,
      processProgress: 0.0,
      error: null,
    );

    try {
      // TODO: Integrar com FFmpeg
      // Simulando processamento por enquanto
      for (int progress = 0; progress <= 100; progress += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        state = state.copyWith(processProgress: progress / 100);
      }

      // Atualiza vídeo como processado
      final processedVideo = state.currentVideo!.copyWith(
        status: VideoStatus.completed,
        processedAt: DateTime.now(),
        jumpCutEnabled: state.jumpCutEnabled,
        audioEnhancementEnabled: state.audioEnhancementEnabled,
        jumpCutThreshold: state.jumpCutThreshold,
        quality: state.outputQuality,
      );

      state = state.copyWith(
        currentVideo: processedVideo,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: 'Erro no processamento: ${e.toString()}',
      );
    }
  }

  // Configurações de processamento
  void toggleJumpCut(bool enabled) {
    state = state.copyWith(jumpCutEnabled: enabled);
  }

  void toggleAudioEnhancement(bool enabled) {
    state = state.copyWith(audioEnhancementEnabled: enabled);
  }

  void setJumpCutThreshold(double threshold) {
    state = state.copyWith(jumpCutThreshold: threshold);
  }

  void setOutputQuality(VideoQuality quality) {
    state = state.copyWith(outputQuality: quality);
  }

  // Reset do editor
  void reset() {
    state = const EditorState();
  }

  // Limpar erros
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Cancelar processamento
  void cancelProcessing() {
    if (state.isProcessing) {
      // TODO: Cancelar processo FFmpeg
      state = state.copyWith(
        isProcessing: false,
        processProgress: 0.0,
      );
    }
  }
}

// Provider do EditorViewModel
final editorViewModelProvider =
    StateNotifierProvider<EditorViewModel, EditorState>(
      (ref) => EditorViewModel(),
    );

// Provider para verificar se há vídeo selecionado
final hasVideoSelectedProvider = Provider<bool>((ref) {
  final editorState = ref.watch(editorViewModelProvider);
  return editorState.selectedVideoPath != null;
});

// Provider para verificar se pode processar
final canProcessProvider = Provider<bool>((ref) {
  final editorState = ref.watch(editorViewModelProvider);
  return editorState.currentVideo != null &&
      !editorState.isProcessing &&
      (editorState.jumpCutEnabled || editorState.audioEnhancementEnabled);
});
