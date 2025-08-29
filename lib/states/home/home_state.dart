import 'package:video_editor/model/models.dart';

class HomeState {
  final List<VideoModel> videos;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.videos = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<VideoModel>? videos,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
