import 'package:video_editor/model/models.dart';

/// Estados da tela Editor seguindo padrão BLoC
abstract class EditorState {
  const EditorState();
}

/// Estado inicial do editor
class EditorInitial extends EditorState {
  const EditorInitial();
}

/// Estado quando vídeo está sendo selecionado
class EditorVideoSelecting extends EditorState {
  const EditorVideoSelecting();
}

/// Estado quando vídeo foi selecionado e carregado
class EditorVideoLoaded extends EditorState {
  final String videoPath;
  final VideoModel? videoModel;
  final bool jumpCutEnabled;
  final bool audioEnhancementEnabled;
  final double jumpCutThreshold;
  final VideoQuality outputQuality;

  const EditorVideoLoaded({
    required this.videoPath,
    this.videoModel,
    this.jumpCutEnabled = true,
    this.audioEnhancementEnabled = true,
    this.jumpCutThreshold = 1.0,
    this.outputQuality = VideoQuality.medium,
  });

  EditorVideoLoaded copyWith({
    String? videoPath,
    VideoModel? videoModel,
    bool? jumpCutEnabled,
    bool? audioEnhancementEnabled,
    double? jumpCutThreshold,
    VideoQuality? outputQuality,
  }) {
    return EditorVideoLoaded(
      videoPath: videoPath ?? this.videoPath,
      videoModel: videoModel ?? this.videoModel,
      jumpCutEnabled: jumpCutEnabled ?? this.jumpCutEnabled,
      audioEnhancementEnabled:
          audioEnhancementEnabled ?? this.audioEnhancementEnabled,
      jumpCutThreshold: jumpCutThreshold ?? this.jumpCutThreshold,
      outputQuality: outputQuality ?? this.outputQuality,
    );
  }
}

/// Estado durante processamento do vídeo
class EditorProcessing extends EditorState {
  final String videoPath;
  final VideoModel? videoModel;
  final bool jumpCutEnabled;
  final bool audioEnhancementEnabled;
  final double jumpCutThreshold;
  final VideoQuality outputQuality;
  final double progress;

  const EditorProcessing({
    required this.videoPath,
    this.videoModel,
    required this.jumpCutEnabled,
    required this.audioEnhancementEnabled,
    required this.jumpCutThreshold,
    required this.outputQuality,
    this.progress = 0.0,
  });

  EditorProcessing copyWith({
    String? videoPath,
    VideoModel? videoModel,
    bool? jumpCutEnabled,
    bool? audioEnhancementEnabled,
    double? jumpCutThreshold,
    VideoQuality? outputQuality,
    double? progress,
  }) {
    return EditorProcessing(
      videoPath: videoPath ?? this.videoPath,
      videoModel: videoModel ?? this.videoModel,
      jumpCutEnabled: jumpCutEnabled ?? this.jumpCutEnabled,
      audioEnhancementEnabled:
          audioEnhancementEnabled ?? this.audioEnhancementEnabled,
      jumpCutThreshold: jumpCutThreshold ?? this.jumpCutThreshold,
      outputQuality: outputQuality ?? this.outputQuality,
      progress: progress ?? this.progress,
    );
  }
}

/// Estado quando processamento foi concluído com sucesso
class EditorProcessingComplete extends EditorState {
  final String originalVideoPath;
  final String processedVideoPath;
  final VideoModel processedVideoModel;

  const EditorProcessingComplete({
    required this.originalVideoPath,
    required this.processedVideoPath,
    required this.processedVideoModel,
  });
}

/// Estado de erro no editor
class EditorError extends EditorState {
  final String message;
  final String? videoPath;
  final VideoModel? videoModel;
  final bool jumpCutEnabled;
  final bool audioEnhancementEnabled;
  final double jumpCutThreshold;
  final VideoQuality outputQuality;

  const EditorError({
    required this.message,
    this.videoPath,
    this.videoModel,
    this.jumpCutEnabled = true,
    this.audioEnhancementEnabled = true,
    this.jumpCutThreshold = 1.0,
    this.outputQuality = VideoQuality.medium,
  });
}
