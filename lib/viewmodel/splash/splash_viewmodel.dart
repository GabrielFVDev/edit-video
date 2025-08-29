import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/states/states.dart';

// Splash ViewModel
class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel() : super(const SplashState());

  // Inicializa o app
  Future<void> initializeApp() async {
    try {
      // Simula carregamento de inicializações
      await Future.delayed(const Duration(milliseconds: 2000));

      // TODO: Verificar se usuário está logado no banco
      // TODO: Carregar configurações do app
      // TODO: Verificar permissões necessárias

      // Por enquanto, sempre vai para login
      state = state.copyWith(status: SplashStatus.unauthenticated);
    } catch (e) {
      state = state.copyWith(
        status: SplashStatus.error,
        error: 'Erro ao inicializar app: ${e.toString()}',
      );
    }
  }

  // Reset do estado
  void reset() {
    state = const SplashState();
  }
}

// Provider do SplashViewModel
final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>(
      (ref) => SplashViewModel(),
    );
