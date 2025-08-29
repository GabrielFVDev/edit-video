import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/model/video/video_model.dart';

/// ViewModel da tela Home - usa BLoC como fonte de dados
class HomeViewModel extends ChangeNotifier {
  final HomeBloc _homeBloc;

  HomeViewModel(this._homeBloc) {
    // Escutar mudanças de estado do BLoC
    _homeBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  // Getters que expõem o estado do BLoC
  HomeState get currentState => _homeBloc.state;

  bool get isLoading => currentState is HomeLoading;
  bool get isEmpty => currentState is HomeEmpty;
  bool get hasError => currentState is HomeError;
  bool get isLoaded => currentState is HomeLoaded;

  List<VideoModel> get videos {
    final state = currentState;
    if (state is HomeLoaded) {
      return state.videos;
    }
    return [];
  }

  String? get errorMessage {
    final state = currentState;
    if (state is HomeError) {
      return state.message;
    }
    return null;
  }

  bool get isRefreshing {
    final state = currentState;
    if (state is HomeLoaded) {
      return state.isRefreshing;
    }
    return false;
  }

  // Métodos que disparam eventos no BLoC
  void loadVideos() {
    _homeBloc.add(const LoadVideos());
  }

  void refreshVideos() {
    _homeBloc.add(const RefreshVideos());
  }

  void addVideo(VideoModel video) {
    _homeBloc.add(AddVideo(video));
  }

  void removeVideo(String videoId) {
    _homeBloc.add(RemoveVideo(videoId));
  }

  void simulateError() {
    _homeBloc.add(const SimulateError());
  }

  void clearError() {
    _homeBloc.add(const ClearError());
  }

  @override
  void dispose() {
    // O BLoC é gerenciado pelo Provider no main.dart
    super.dispose();
  }
}
