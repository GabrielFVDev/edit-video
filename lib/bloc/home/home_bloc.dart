import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'home_state.dart';
import 'home_action.dart';

/// BLoC para gerenciar estado da tela Home
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    // Registrar handlers para cada evento
    on<LoadVideos>(_onLoadVideos);
    on<RefreshVideos>(_onRefreshVideos);
    on<AddVideo>(_onAddVideo);
    on<RemoveVideo>(_onRemoveVideo);
    on<SimulateError>(_onSimulateError);
    on<ClearError>(_onClearError);
  }

  /// Handler para carregar vídeos
  Future<void> _onLoadVideos(LoadVideos event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    try {
      // Simular carregamento
      await Future.delayed(const Duration(seconds: 2));

      // Simular lista de vídeos (substitua pela lógica real)
      final videos = _getMockVideos();

      if (videos.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeLoaded(videos: videos));
      }
    } catch (e) {
      emit(HomeError(message: 'Erro ao carregar vídeos: ${e.toString()}'));
    }
  }

  /// Handler para atualizar lista
  Future<void> _onRefreshVideos(
    RefreshVideos event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(isRefreshing: true));
    } else {
      emit(const HomeLoading());
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      final videos = _getMockVideos();

      if (videos.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeLoaded(videos: videos));
      }
    } catch (e) {
      emit(HomeError(message: 'Erro ao atualizar vídeos: ${e.toString()}'));
    }
  }

  /// Handler para adicionar vídeo
  void _onAddVideo(AddVideo event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedVideos = [...currentState.videos, event.video];
      emit(currentState.copyWith(videos: updatedVideos));
    } else if (currentState is HomeEmpty) {
      emit(HomeLoaded(videos: [event.video]));
    }
  }

  /// Handler para remover vídeo
  void _onRemoveVideo(RemoveVideo event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final updatedVideos = currentState.videos
          .where((video) => video.id != event.videoId)
          .toList();

      if (updatedVideos.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(currentState.copyWith(videos: updatedVideos));
      }
    }
  }

  /// Handler para simular erro
  void _onSimulateError(SimulateError event, Emitter<HomeState> emit) {
    final currentState = state;
    List<VideoModel>? currentVideos;

    if (currentState is HomeLoaded) {
      currentVideos = currentState.videos;
    }

    emit(
      HomeError(
        message: 'Erro simulado para testes',
        videos: currentVideos,
      ),
    );
  }

  /// Handler para limpar erro
  void _onClearError(ClearError event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeError) {
      if (currentState.videos != null && currentState.videos!.isNotEmpty) {
        emit(HomeLoaded(videos: currentState.videos!));
      } else {
        emit(const HomeEmpty());
      }
    }
  }

  /// Mock de vídeos para teste
  List<VideoModel> _getMockVideos() {
    return [
      VideoModel(
        id: '1',
        title: 'Vídeo Exemplo 1',
        description: 'Descrição do vídeo exemplo 1',
        originalPath: '/path/video1.mp4',
        thumbnailPath: '/path/thumb1.jpg',
        status: VideoStatus.completed,
        durationInSeconds: 150, // 2 min 30 sec
        fileSizeInBytes: 1024000,
        userId: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      VideoModel(
        id: '2',
        title: 'Vídeo Exemplo 2',
        description: 'Descrição do vídeo exemplo 2',
        originalPath: '/path/video2.mp4',
        thumbnailPath: '/path/thumb2.jpg',
        status: VideoStatus.completed,
        durationInSeconds: 345, // 5 min 45 sec
        fileSizeInBytes: 2048000,
        userId: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
