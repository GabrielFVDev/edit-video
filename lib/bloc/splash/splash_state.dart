/// Estados da tela Splash seguindo padrão BLoC
abstract class SplashState {
  const SplashState();
}

/// Estado inicial do splash
class SplashInitial extends SplashState {
  const SplashInitial();
}

/// Estado de carregamento/inicialização
class SplashLoading extends SplashState {
  final double progress;
  final String? message;

  const SplashLoading({
    this.progress = 0.0,
    this.message,
  });

  SplashLoading copyWith({
    double? progress,
    String? message,
  }) {
    return SplashLoading(
      progress: progress ?? this.progress,
      message: message ?? this.message,
    );
  }
}

/// Estado quando inicialização está completa
class SplashComplete extends SplashState {
  final bool userLoggedIn;
  final String? nextRoute;

  const SplashComplete({
    required this.userLoggedIn,
    this.nextRoute,
  });
}

/// Estado de erro durante inicialização
class SplashError extends SplashState {
  final String message;

  const SplashError({
    required this.message,
  });
}
