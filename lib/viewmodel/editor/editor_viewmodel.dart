import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/model/video/video_model.dart';

/// ViewModel da tela Editor - usa BLoC como fonte de dados
class EditorViewModel extends ChangeNotifier {
  final EditorBloc _editorBloc;
  
  EditorViewModel(this._editorBloc) {
    // Escutar mudanças de estado do BLoC
    _editorBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  // Getters que expõem o estado do BLoC
  EditorState get currentState => _editorBloc.state;
  
  bool get isInitial => currentState is EditorInitial;
  bool get isVideoSelecting => currentState is EditorVideoSelecting;
  bool get isVideoLoaded => currentState is EditorVideoLoaded;
  bool get isProcessing => currentState is EditorProcessing;
  bool get isProcessingComplete => currentState is EditorProcessingComplete;
  bool get hasError => currentState is EditorError;
  
  String? get videoPath {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.videoPath;
    if (state is EditorProcessing) return state.videoPath;
    if (state is EditorError) return state.videoPath;
    return null;
  }
  
  VideoModel? get videoModel {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.videoModel;
    if (state is EditorProcessing) return state.videoModel;
    if (state is EditorError) return state.videoModel;
    return null;
  }
  
  bool get jumpCutEnabled {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.jumpCutEnabled;
    if (state is EditorProcessing) return state.jumpCutEnabled;
    if (state is EditorError) return state.jumpCutEnabled;
    return true;
  }
  
  bool get audioEnhancementEnabled {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.audioEnhancementEnabled;
    if (state is EditorProcessing) return state.audioEnhancementEnabled;
    if (state is EditorError) return state.audioEnhancementEnabled;
    return true;
  }
  
  double get jumpCutThreshold {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.jumpCutThreshold;
    if (state is EditorProcessing) return state.jumpCutThreshold;
    if (state is EditorError) return state.jumpCutThreshold;
    return 1.0;
  }
  
  VideoQuality get outputQuality {
    final state = currentState;
    if (state is EditorVideoLoaded) return state.outputQuality;
    if (state is EditorProcessing) return state.outputQuality;
    if (state is EditorError) return state.outputQuality;
    return VideoQuality.medium;
  }
  
  double get progress {
    final state = currentState;
    if (state is EditorProcessing) return state.progress;
    return 0.0;
  }
  
  String? get errorMessage {
    final state = currentState;
    if (state is EditorError) return state.message;
    return null;
  }
  
  String? get processedVideoPath {
    final state = currentState;
    if (state is EditorProcessingComplete) return state.processedVideoPath;
    return null;
  }
  
  VideoModel? get processedVideoModel {
    final state = currentState;
    if (state is EditorProcessingComplete) return state.processedVideoModel;
    return null;
  }

  // Getters de conveniência para UI
  bool get hasVideo => videoPath != null;
  bool get canStartProcessing => isVideoLoaded && !isProcessing;
  bool get canCancelProcessing => isProcessing;
  bool get showProgressIndicator => isProcessing || isVideoSelecting;
  
  String get progressText {
    if (isVideoSelecting) return 'Selecionando vídeo...';
    if (isProcessing) return 'Processando... ${(progress * 100).toInt()}%';
    return '';
  }
  
  String get videoDisplayName {
    if (videoModel?.title != null) return videoModel!.title;
    if (videoPath != null) {
      return videoPath!.split('/').last;
    }
    return 'Nenhum vídeo selecionado';
  }

  // Métodos que disparam eventos no BLoC
  void selectVideoFromGallery() {
    _editorBloc.add(const SelectVideoFromGallery());
  }
  
  void recordNewVideo() {
    _editorBloc.add(const RecordNewVideo());
  }
  
  void startProcessing() {
    if (canStartProcessing) {
      _editorBloc.add(const StartProcessing());
    }
  }
  
  void cancelProcessing() {
    if (canCancelProcessing) {
      _editorBloc.add(const CancelProcessing());
    }
  }
  
  void toggleJumpCut(bool enabled) {
    _editorBloc.add(ToggleJumpCut(enabled));
  }
  
  void toggleAudioEnhancement(bool enabled) {
    _editorBloc.add(ToggleAudioEnhancement(enabled));
  }
  
  void setJumpCutThreshold(double threshold) {
    if (threshold >= 0.1 && threshold <= 5.0) {
      _editorBloc.add(SetJumpCutThreshold(threshold));
    }
  }
  
  void setOutputQuality(VideoQuality quality) {
    _editorBloc.add(SetOutputQuality(quality));
  }
  
  void resetEditor() {
    _editorBloc.add(const ResetEditor());
  }
  
  void clearError() {
    if (hasError) {
      _editorBloc.add(const ClearEditorError());
    }
  }

  // Métodos auxiliares para configurações
  void incrementJumpCutThreshold() {
    final current = jumpCutThreshold;
    if (current < 5.0) {
      setJumpCutThreshold((current + 0.1).clamp(0.1, 5.0));
    }
  }
  
  void decrementJumpCutThreshold() {
    final current = jumpCutThreshold;
    if (current > 0.1) {
      setJumpCutThreshold((current - 0.1).clamp(0.1, 5.0));
    }
  }
  
  void setQualityToLow() => setOutputQuality(VideoQuality.low);
  void setQualityToMedium() => setOutputQuality(VideoQuality.medium);
  void setQualityToHigh() => setOutputQuality(VideoQuality.high);
  void setQualityToUltra() => setOutputQuality(VideoQuality.ultra);
  
  String getQualityDisplayName() {
    switch (outputQuality) {
      case VideoQuality.low:
        return 'Baixa (480p)';
      case VideoQuality.medium:
        return 'Média (720p)';
      case VideoQuality.high:
        return 'Alta (1080p)';
      case VideoQuality.ultra:
        return 'Ultra (4K)';
    }
  }

  @override
  void dispose() {
    // O BLoC é gerenciado pelo Provider no main.dart
    super.dispose();
  }
}