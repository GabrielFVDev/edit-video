/// Eventos que podem ser disparados na tela Splash
abstract class SplashEvent {
  const SplashEvent();
}

/// Inicializar aplicação
class InitializeApp extends SplashEvent {
  const InitializeApp();
}

/// Verificar se usuário está logado
class CheckUserLoginStatus extends SplashEvent {
  const CheckUserLoginStatus();
}

/// Carregar configurações do app
class LoadAppSettings extends SplashEvent {
  const LoadAppSettings();
}

/// Atualizar progresso de inicialização
class UpdateProgress extends SplashEvent {
  final double progress;
  final String? message;

  const UpdateProgress(this.progress, {this.message});
}

/// Navegar para próxima tela
class NavigateToNextScreen extends SplashEvent {
  const NavigateToNextScreen();
}

/// Reiniciar splash em caso de erro
class RestartSplash extends SplashEvent {
  const RestartSplash();
}
