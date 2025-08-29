import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'editor_state.dart';
import 'editor_action.dart';

/// BLoC para gerenciar estado da tela Editor
class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(const EditorInitial()) {
    on<SelectVideoFromGallery>(_onSelectVideoFromGallery);
    on<RecordNewVideo>(_onRecordNewVideo);
    on<StartProcessing>(_onStartProcessing);
    on<CancelProcessing>(_onCancelProcessing);
    on<ToggleJumpCut>(_onToggleJumpCut);
    on<ToggleAudioEnhancement>(_onToggleAudioEnhancement);
    on<SetJumpCutThreshold>(_onSetJumpCutThreshold);
    on<SetOutputQuality>(_onSetOutputQuality);
    on<ResetEditor>(_onResetEditor);
    on<ClearEditorError>(_onClearEditorError);
  }

  /// Handler para selecionar vídeo da galeria
  Future<void> _onSelectVideoFromGallery(
    SelectVideoFromGallery event,
    Emitter<EditorState> emit,
  ) async {
    emit(const EditorVideoSelecting());

    try {
      // Simular seleção de vídeo
      await Future.delayed(const Duration(seconds: 1));

      // Mock de vídeo selecionado
      const videoPath = '/mock/path/selected_video.mp4';

      emit(const EditorVideoLoaded(videoPath: videoPath));
    } catch (e) {
      emit(EditorError(message: 'Erro ao selecionar vídeo: ${e.toString()}'));
    }
  }

  /// Handler para gravar novo vídeo
  Future<void> _onRecordNewVideo(
    RecordNewVideo event,
    Emitter<EditorState> emit,
  ) async {
    emit(const EditorVideoSelecting());

    try {
      // Simular gravação de vídeo
      await Future.delayed(const Duration(seconds: 2));

      // Mock de vídeo gravado
      const videoPath = '/mock/path/recorded_video.mp4';

      emit(const EditorVideoLoaded(videoPath: videoPath));
    } catch (e) {
      emit(EditorError(message: 'Erro ao gravar vídeo: ${e.toString()}'));
    }
  }

  /// Handler para iniciar processamento
  Future<void> _onStartProcessing(
    StartProcessing event,
    Emitter<EditorState> emit,
  ) async {
    final currentState = state;
    if (currentState is! EditorVideoLoaded) return;

    emit(
      EditorProcessing(
        videoPath: currentState.videoPath,
        videoModel: currentState.videoModel,
        jumpCutEnabled: currentState.jumpCutEnabled,
        audioEnhancementEnabled: currentState.audioEnhancementEnabled,
        jumpCutThreshold: currentState.jumpCutThreshold,
        outputQuality: currentState.outputQuality,
        progress: 0.0,
      ),
    );

    try {
      // Simular processamento com progresso
      for (double progress = 0.0; progress <= 1.0; progress += 0.1) {
        await Future.delayed(const Duration(milliseconds: 300));

        if (state is EditorProcessing) {
          emit((state as EditorProcessing).copyWith(progress: progress));
        }
      }

      // Mock de vídeo processado
      final processedVideo = VideoModel(
        id: 'processed_1',
        title: 'Vídeo Processado',
        description: 'Vídeo processado com sucesso',
        originalPath: currentState.videoPath,
        processedPath: '/mock/path/processed_video.mp4',
        status: VideoStatus.completed,
        quality: currentState.outputQuality,
        durationInSeconds: 120,
        fileSizeInBytes: 1024000,
        userId: 'user1',
        createdAt: DateTime.now(),
        processedAt: DateTime.now(),
      );

      emit(
        EditorProcessingComplete(
          originalVideoPath: currentState.videoPath,
          processedVideoPath: '/mock/path/processed_video.mp4',
          processedVideoModel: processedVideo,
        ),
      );
    } catch (e) {
      emit(
        EditorError(
          message: 'Erro durante processamento: ${e.toString()}',
          videoPath: currentState.videoPath,
          videoModel: currentState.videoModel,
          jumpCutEnabled: currentState.jumpCutEnabled,
          audioEnhancementEnabled: currentState.audioEnhancementEnabled,
          jumpCutThreshold: currentState.jumpCutThreshold,
          outputQuality: currentState.outputQuality,
        ),
      );
    }
  }

  /// Handler para cancelar processamento
  void _onCancelProcessing(CancelProcessing event, Emitter<EditorState> emit) {
    final currentState = state;
    if (currentState is EditorProcessing) {
      emit(
        EditorVideoLoaded(
          videoPath: currentState.videoPath,
          videoModel: currentState.videoModel,
          jumpCutEnabled: currentState.jumpCutEnabled,
          audioEnhancementEnabled: currentState.audioEnhancementEnabled,
          jumpCutThreshold: currentState.jumpCutThreshold,
          outputQuality: currentState.outputQuality,
        ),
      );
    }
  }

  /// Handler para alternar jump cut
  void _onToggleJumpCut(ToggleJumpCut event, Emitter<EditorState> emit) {
    final currentState = state;
    if (currentState is EditorVideoLoaded) {
      emit(currentState.copyWith(jumpCutEnabled: event.enabled));
    }
  }

  /// Handler para alternar melhoria de áudio
  void _onToggleAudioEnhancement(
    ToggleAudioEnhancement event,
    Emitter<EditorState> emit,
  ) {
    final currentState = state;
    if (currentState is EditorVideoLoaded) {
      emit(currentState.copyWith(audioEnhancementEnabled: event.enabled));
    }
  }

  /// Handler para definir threshold do jump cut
  void _onSetJumpCutThreshold(
    SetJumpCutThreshold event,
    Emitter<EditorState> emit,
  ) {
    final currentState = state;
    if (currentState is EditorVideoLoaded) {
      emit(currentState.copyWith(jumpCutThreshold: event.threshold));
    }
  }

  /// Handler para definir qualidade de saída
  void _onSetOutputQuality(SetOutputQuality event, Emitter<EditorState> emit) {
    final currentState = state;
    if (currentState is EditorVideoLoaded) {
      emit(currentState.copyWith(outputQuality: event.quality));
    }
  }

  /// Handler para resetar editor
  void _onResetEditor(ResetEditor event, Emitter<EditorState> emit) {
    emit(const EditorInitial());
  }

  /// Handler para limpar erro
  void _onClearEditorError(ClearEditorError event, Emitter<EditorState> emit) {
    final currentState = state;
    if (currentState is EditorError && currentState.videoPath != null) {
      emit(
        EditorVideoLoaded(
          videoPath: currentState.videoPath!,
          videoModel: currentState.videoModel,
          jumpCutEnabled: currentState.jumpCutEnabled,
          audioEnhancementEnabled: currentState.audioEnhancementEnabled,
          jumpCutThreshold: currentState.jumpCutThreshold,
          outputQuality: currentState.outputQuality,
        ),
      );
    } else {
      emit(const EditorInitial());
    }
  }
}
