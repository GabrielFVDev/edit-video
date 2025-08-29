import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/states/states.dart';
import '../../model/models.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState());

  // Carrega vídeos do usuário
  Future<void> loadVideos() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Buscar vídeos do banco SQLite
      // Por enquanto, dados mockados
      await Future.delayed(const Duration(seconds: 1));

      final mockVideos = [
        VideoModel(
          id: '1',
          title: 'Meu primeiro vídeo',
          description: 'Teste de edição',
          originalPath: '/path/to/video1.mp4',
          status: VideoStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          durationInSeconds: 165, // 2:45
          fileSizeInBytes: 15943680, // ~15.2 MB
          userId: 'user1',
          processedAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        VideoModel(
          id: '2',
          title: 'Apresentação do projeto',
          description: 'Vídeo para apresentar o MVP',
          originalPath: '/path/to/video2.mp4',
          status: VideoStatus.processing,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          durationInSeconds: 332, // 5:32
          fileSizeInBytes: 44195635, // ~42.1 MB
          userId: 'user1',
        ),
        VideoModel(
          id: '3',
          title: 'Tutorial de Flutter',
          description: 'Explicando conceitos básicos',
          originalPath: '/path/to/video3.mp4',
          status: VideoStatus.failed,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          durationInSeconds: 738, // 12:18
          fileSizeInBytes: 164378214, // ~156.7 MB
          userId: 'user1',
        ),
      ];

      state = state.copyWith(
        videos: mockVideos,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao carregar vídeos: ${e.toString()}',
      );
    }
  }

  // Deleta um vídeo
  Future<void> deleteVideo(String videoId) async {
    try {
      // TODO: Deletar do banco e arquivos
      final updatedVideos = state.videos.where((v) => v.id != videoId).toList();
      state = state.copyWith(videos: updatedVideos);
    } catch (e) {
      state = state.copyWith(
        error: 'Erro ao deletar vídeo: ${e.toString()}',
      );
    }
  }

  // Atualiza status de um vídeo específico
  void updateVideoStatus(String videoId, VideoStatus status) {
    final updatedVideos = state.videos.map((video) {
      if (video.id == videoId) {
        return video.copyWith(
          status: status,
          processedAt: status == VideoStatus.completed ? DateTime.now() : null,
        );
      }
      return video;
    }).toList();

    state = state.copyWith(videos: updatedVideos);
  }

  // Adiciona novo vídeo
  void addVideo(VideoModel video) {
    final updatedVideos = [video, ...state.videos];
    state = state.copyWith(videos: updatedVideos);
  }

  // Limpar erros
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Refresh
  Future<void> refresh() async {
    await loadVideos();
  }
}

// Provider do HomeViewModel
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(),
);

// Provider para filtrar vídeos por status
final videosByStatusProvider = Provider.family<List<VideoModel>, VideoStatus>((
  ref,
  status,
) {
  final homeState = ref.watch(homeViewModelProvider);
  return homeState.videos.where((video) => video.status == status).toList();
});

// Provider para contar vídeos por status
final videoCountByStatusProvider = Provider.family<int, VideoStatus>((
  ref,
  status,
) {
  final videos = ref.watch(videosByStatusProvider(status));
  return videos.length;
});
