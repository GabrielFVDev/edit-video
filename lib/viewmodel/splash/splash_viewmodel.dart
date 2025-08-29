import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';

/// ViewModel da tela Splash - usa BLoC como fonte de dados
class SplashViewModel extends ChangeNotifier {
  final SplashBloc _splashBloc;

  SplashViewModel(this._splashBloc) {
    // Escutar mudanças de estado do BLoC
    _splashBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  // Getters que expõem o estado do BLoC
  SplashState get currentState => _splashBloc.state;

  bool get isInitial => currentState is SplashInitial;
  bool get isLoading => currentState is SplashLoading;
  bool get isComplete => currentState is SplashComplete;
  bool get hasError => currentState is SplashError;

  double get progress {
    final state = currentState;
    if (state is SplashLoading) {
      return state.progress;
    }
    return 0.0;
  }

  String? get message {
    final state = currentState;
    if (state is SplashLoading) {
      return state.message;
    }
    return null;
  }

  String? get errorMessage {
    final state = currentState;
    if (state is SplashError) {
      return state.message;
    }
    return null;
  }

  bool get userLoggedIn {
    final state = currentState;
    if (state is SplashComplete) {
      return state.userLoggedIn;
    }
    return false;
  }

  String? get nextRoute {
    final state = currentState;
    if (state is SplashComplete) {
      return state.nextRoute;
    }
    return null;
  }

  // Métodos que disparam eventos no BLoC
  void initializeApp() {
    _splashBloc.add(const InitializeApp());
  }

  void checkUserLoginStatus() {
    _splashBloc.add(const CheckUserLoginStatus());
  }

  void loadAppSettings() {
    _splashBloc.add(const LoadAppSettings());
  }

  void updateProgress(double progress, {String? message}) {
    _splashBloc.add(UpdateProgress(progress, message: message));
  }

  void navigateToNextScreen() {
    _splashBloc.add(const NavigateToNextScreen());
  }

  void restartSplash() {
    _splashBloc.add(const RestartSplash());
  }

  @override
  void dispose() {
    // O BLoC é gerenciado pelo Provider no main.dart
    super.dispose();
  }
}
