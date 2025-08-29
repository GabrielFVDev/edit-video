import 'package:video_editor/model/models.dart';

class EditorState {
  final String? selectedVideoPath;
  final VideoModel? currentVideo;
  final bool isProcessing;
  final double processProgress;
  final String? error;

  // Configurações de processamento
  final bool jumpCutEnabled;
  final bool audioEnhancementEnabled;
  final double jumpCutThreshold;
  final VideoQuality outputQuality;

  const EditorState({
    this.selectedVideoPath,
    this.currentVideo,
    this.isProcessing = false,
    this.processProgress = 0.0,
    this.error,
    this.jumpCutEnabled = true,
    this.audioEnhancementEnabled = true,
    this.jumpCutThreshold = 1.0,
    this.outputQuality = VideoQuality.medium,
  });

  EditorState copyWith({
    String? selectedVideoPath,
    VideoModel? currentVideo,
    bool? isProcessing,
    double? processProgress,
    String? error,
    bool? jumpCutEnabled,
    bool? audioEnhancementEnabled,
    double? jumpCutThreshold,
    VideoQuality? outputQuality,
  }) {
    return EditorState(
      selectedVideoPath: selectedVideoPath ?? this.selectedVideoPath,
      currentVideo: currentVideo ?? this.currentVideo,
      isProcessing: isProcessing ?? this.isProcessing,
      processProgress: processProgress ?? this.processProgress,
      error: error,
      jumpCutEnabled: jumpCutEnabled ?? this.jumpCutEnabled,
      audioEnhancementEnabled:
          audioEnhancementEnabled ?? this.audioEnhancementEnabled,
      jumpCutThreshold: jumpCutThreshold ?? this.jumpCutThreshold,
      outputQuality: outputQuality ?? this.outputQuality,
    );
  }
}
