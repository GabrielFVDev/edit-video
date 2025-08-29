import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/models.dart';
import '../../states/states.dart';

// Estados do Auth

// Auth ViewModel
class LoginViewModel extends StateNotifier<AuthState> {
  LoginViewModel() : super(const AuthState());

  // Simula login (futuramente conectará com banco/API)
  Future<bool> login(String name, String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simula delay de autenticação
      await Future.delayed(const Duration(seconds: 2));

      // Validações básicas
      if (name.trim().length < 2) {
        state = state.copyWith(
          isLoading: false,
          error: 'Nome deve ter pelo menos 2 caracteres',
        );
        return false;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.trim())) {
        state = state.copyWith(
          isLoading: false,
          error: 'Email inválido',
        );
        return false;
      }

      // Cria usuário
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        email: email.trim().toLowerCase(),
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      // TODO: Salvar no banco local (SQLite)

      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: true,
        error: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao fazer login: ${e.toString()}',
      );
      return false;
    }
  }

  // Logout
  void logout() {
    // TODO: Limpar dados do banco
    state = const AuthState();
  }

  // Verificar se usuário já está logado (para splash)
  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO: Verificar no banco se há usuário salvo
      await Future.delayed(const Duration(seconds: 1));

      // Por enquanto, sempre não autenticado
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao verificar autenticação',
      );
    }
  }

  // Limpar erros
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider do LoginViewModel
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AuthState>(
  (ref) => LoginViewModel(),
);

// Provider para verificar se está autenticado (helper)
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(loginViewModelProvider);
  return authState.isAuthenticated;
});

// Provider para o usuário atual (helper)
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(loginViewModelProvider);
  return authState.user;
});
