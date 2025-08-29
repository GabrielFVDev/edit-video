import 'package:video_editor/model/video/video_model.dart';

/// Eventos que podem ser disparados na tela Editor
abstract class EditorEvent {
  const EditorEvent();
}

/// Selecionar vídeo da galeria
class SelectVideoFromGallery extends EditorEvent {
  const SelectVideoFromGallery();
}

/// Gravar novo vídeo
class RecordNewVideo extends EditorEvent {
  const RecordNewVideo();
}

/// Iniciar processamento do vídeo
class StartProcessing extends EditorEvent {
  const StartProcessing();
}

/// Cancelar processamento
class CancelProcessing extends EditorEvent {
  const CancelProcessing();
}

/// Alternar jump cut on/off
class ToggleJumpCut extends EditorEvent {
  final bool enabled;

  const ToggleJumpCut(this.enabled);
}

/// Alternar melhoria de áudio on/off
class ToggleAudioEnhancement extends EditorEvent {
  final bool enabled;

  const ToggleAudioEnhancement(this.enabled);
}

/// Definir threshold do jump cut
class SetJumpCutThreshold extends EditorEvent {
  final double threshold;

  const SetJumpCutThreshold(this.threshold);
}

/// Definir qualidade de saída
class SetOutputQuality extends EditorEvent {
  final VideoQuality quality;

  const SetOutputQuality(this.quality);
}

/// Resetar editor ao estado inicial
class ResetEditor extends EditorEvent {
  const ResetEditor();
}

/// Limpar erro
class ClearEditorError extends EditorEvent {
  const ClearEditorError();
}
