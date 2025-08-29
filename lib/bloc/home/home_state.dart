import 'package:video_editor/model/video/video_model.dart';

/// Estados da tela Home seguindo padrão BLoC
abstract class HomeState {
  const HomeState();
}

/// Estado inicial da home
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Estado de carregamento
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Estado quando não há vídeos
class HomeEmpty extends HomeState {
  const HomeEmpty();
}

/// Estado com lista de vídeos carregada
class HomeLoaded extends HomeState {
  final List<VideoModel> videos;
  final bool isRefreshing;

  const HomeLoaded({
    required this.videos,
    this.isRefreshing = false,
  });

  HomeLoaded copyWith({
    List<VideoModel>? videos,
    bool? isRefreshing,
  }) {
    return HomeLoaded(
      videos: videos ?? this.videos,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

/// Estado de erro
class HomeError extends HomeState {
  final String message;
  final List<VideoModel>? videos; // Manter vídeos se houver

  const HomeError({
    required this.message,
    this.videos,
  });
}
