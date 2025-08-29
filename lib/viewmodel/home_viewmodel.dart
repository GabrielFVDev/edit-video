import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/core/constants/app_view_state.dart';
import 'package:video_editor/model/video/video_model.dart';

/// Provider para gerenciar o estado da HomeView
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AppViewState<List<VideoModel>>>(
      (ref) => HomeViewModel(),
    );

class HomeViewModel extends StateNotifier<AppViewState<List<VideoModel>>> {
  HomeViewModel() : super(AppViewState.loading()) {
    // Simula carregamento inicial
    _loadVideos();
  }

  /// Simula o carregamento de vídeos
  Future<void> _loadVideos() async {
    // Simula delay de carregamento
    await Future.delayed(const Duration(milliseconds: 500));

    // Por enquanto, simula lista vazia
    // Em produção, aqui seria a chamada para o repositório
    final videos = <VideoModel>[];

    if (videos.isEmpty) {
      state = AppViewState.empty();
    } else {
      state = AppViewState.content(videos);
    }
  }

  /// Adiciona um novo vídeo à lista
  void addVideo(VideoModel video) {
    final currentVideos = state.data ?? <VideoModel>[];
    final updatedVideos = [...currentVideos, video];
    state = AppViewState.content(updatedVideos);
  }

  /// Remove um vídeo da lista
  void removeVideo(String videoId) {
    final currentVideos = state.data ?? <VideoModel>[];
    final updatedVideos = currentVideos.where((v) => v.id != videoId).toList();

    if (updatedVideos.isEmpty) {
      state = AppViewState.empty();
    } else {
      state = AppViewState.content(updatedVideos);
    }
  }

  /// Recarrega a lista de vídeos
  Future<void> refreshVideos() async {
    state = AppViewState.loading();
    await _loadVideos();
  }

  /// Simula um erro
  void simulateError() {
    state = AppViewState.error(
      'Erro ao carregar vídeos. Verifique sua conexão.',
    );
  }

  /// Limpa o erro e recarrega
  Future<void> clearError() async {
    await refreshVideos();
  }
}
