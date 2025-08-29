import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';
import 'splash_action.dart';

/// BLoC para gerenciar estado da tela Splash
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<InitializeApp>(_onInitializeApp);
    on<CheckUserLoginStatus>(_onCheckUserLoginStatus);
    on<LoadAppSettings>(_onLoadAppSettings);
    on<UpdateProgress>(_onUpdateProgress);
    on<NavigateToNextScreen>(_onNavigateToNextScreen);
    on<RestartSplash>(_onRestartSplash);
  }

  /// Handler para inicializar aplicação
  Future<void> _onInitializeApp(
    InitializeApp event,
    Emitter<SplashState> emit,
  ) async {
    try {
      // Simular processo de inicialização
      emit(const SplashLoading(progress: 0.0, message: 'Inicializando...'));

      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        const SplashLoading(
          progress: 0.3,
          message: 'Carregando configurações...',
        ),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        const SplashLoading(progress: 0.6, message: 'Verificando usuário...'),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      emit(const SplashLoading(progress: 0.9, message: 'Finalizando...'));

      await Future.delayed(const Duration(milliseconds: 500));

      // Verificar se usuário está logado (mock)
      final isLoggedIn = _checkIfUserIsLoggedIn();

      emit(
        SplashComplete(
          userLoggedIn: isLoggedIn,
          nextRoute: isLoggedIn ? '/home' : '/login',
        ),
      );
    } catch (e) {
      emit(SplashError(message: 'Erro na inicialização: ${e.toString()}'));
    }
  }

  /// Handler para verificar status de login
  Future<void> _onCheckUserLoginStatus(
    CheckUserLoginStatus event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading(message: 'Verificando login...'));

      await Future.delayed(const Duration(seconds: 1));
      final isLoggedIn = _checkIfUserIsLoggedIn();

      emit(
        SplashComplete(
          userLoggedIn: isLoggedIn,
          nextRoute: isLoggedIn ? '/home' : '/login',
        ),
      );
    } catch (e) {
      emit(SplashError(message: 'Erro ao verificar login: ${e.toString()}'));
    }
  }

  /// Handler para carregar configurações
  Future<void> _onLoadAppSettings(
    LoadAppSettings event,
    Emitter<SplashState> emit,
  ) async {
    try {
      emit(const SplashLoading(message: 'Carregando configurações...'));

      // Simular carregamento de configurações
      await Future.delayed(const Duration(seconds: 1));

      // Continuar com o fluxo normal
      add(const CheckUserLoginStatus());
    } catch (e) {
      emit(
        SplashError(message: 'Erro ao carregar configurações: ${e.toString()}'),
      );
    }
  }

  /// Handler para atualizar progresso
  void _onUpdateProgress(UpdateProgress event, Emitter<SplashState> emit) {
    emit(
      SplashLoading(
        progress: event.progress,
        message: event.message,
      ),
    );
  }

  /// Handler para navegar para próxima tela
  void _onNavigateToNextScreen(
    NavigateToNextScreen event,
    Emitter<SplashState> emit,
  ) {
    final isLoggedIn = _checkIfUserIsLoggedIn();
    emit(
      SplashComplete(
        userLoggedIn: isLoggedIn,
        nextRoute: isLoggedIn ? '/home' : '/login',
      ),
    );
  }

  /// Handler para reiniciar splash
  void _onRestartSplash(RestartSplash event, Emitter<SplashState> emit) {
    emit(const SplashInitial());
    add(const InitializeApp());
  }

  /// Método mock para verificar se usuário está logado
  bool _checkIfUserIsLoggedIn() {
    // Implementar lógica real de verificação
    // Por enquanto, retorna false (usuário não logado)
    return false;
  }
}
