import 'package:video_editor/model/video/video_model.dart';

/// Eventos que podem ser disparados na tela Home
abstract class HomeEvent {
  const HomeEvent();
}

/// Carregar lista de vídeos
class LoadVideos extends HomeEvent {
  const LoadVideos();
}

/// Atualizar/Refresh lista de vídeos
class RefreshVideos extends HomeEvent {
  const RefreshVideos();
}

/// Adicionar novo vídeo à lista
class AddVideo extends HomeEvent {
  final VideoModel video;

  const AddVideo(this.video);
}

/// Remover vídeo da lista
class RemoveVideo extends HomeEvent {
  final String videoId;

  const RemoveVideo(this.videoId);
}

/// Simular erro (para testes)
class SimulateError extends HomeEvent {
  const SimulateError();
}

/// Limpar estado de erro
class ClearError extends HomeEvent {
  const ClearError();
}
