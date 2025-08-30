import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/model/video/video_model.dart';
import 'home_state.dart';
import 'home_action.dart';

/// BLoC para gerenciar estado da tela Home
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Lista interna para armazenar vídeos (temporário, será substituída pelo SQLite)
  final List<VideoModel> _videos = [];

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
      await Future.delayed(const Duration(milliseconds: 500));

      // Usar lista real de vídeos
      if (_videos.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeLoaded(videos: List.from(_videos)));
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
      await Future.delayed(const Duration(milliseconds: 500));

      if (_videos.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeLoaded(videos: List.from(_videos)));
      }
    } catch (e) {
      emit(HomeError(message: 'Erro ao atualizar vídeos: ${e.toString()}'));
    }
  }

  /// Handler para adicionar vídeo
  void _onAddVideo(AddVideo event, Emitter<HomeState> emit) {
    // Adicionar à lista interna
    _videos.add(event.video);

    // Emitir novo estado
    emit(HomeLoaded(videos: List.from(_videos)));
  }

  /// Handler para remover vídeo
  void _onRemoveVideo(RemoveVideo event, Emitter<HomeState> emit) {
    // Remover da lista interna
    _videos.removeWhere((video) => video.id == event.videoId);

    // Emitir novo estado
    if (_videos.isEmpty) {
      emit(const HomeEmpty());
    } else {
      emit(HomeLoaded(videos: List.from(_videos)));
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
}
