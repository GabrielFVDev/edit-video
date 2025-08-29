// Estados do Splash
enum SplashStatus { loading, authenticated, unauthenticated, error }

class SplashState {
  final SplashStatus status;
  final String? error;

  const SplashState({
    this.status = SplashStatus.loading,
    this.error,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? error,
  }) {
    return SplashState(
      status: status ?? this.status,
      error: error,
    );
  }
}
