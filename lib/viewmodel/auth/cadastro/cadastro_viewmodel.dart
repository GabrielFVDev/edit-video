import 'package:flutter/material.dart';
import 'package:video_editor/model/user/user_model.dart';

/// ViewModel da tela Cadastro - usa estado interno para evitar efeitos colaterais
class CadastroViewModel extends ChangeNotifier {
  // Mantemos a assinatura compatível (se outro código passar um bloc),
  // mas não dependemos dele para o fluxo de cadastro.
  CadastroViewModel([dynamic _maybeLoginBloc]);

  bool _isLoading = false;
  bool _isSuccess = false;
  bool _hasError = false;
  String? _errorMessage;
  UserModel? _user;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

  /// Simula criação de conta e marca que o usuário possui conta
  Future<void> performCadastro(String email, String name) async {
    if (_isLoading) return;
    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      // Simular chamada de rede / criação de conta
      await Future.delayed(const Duration(seconds: 2));

      // Criar usuário mock
      _user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      _isSuccess = true;
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Erro ao criar conta: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void validateEmail(String email) {
    // validação local opcional
    // ...não necessário aqui
  }

  void validateName(String name) {}

  void validateForm(String email, String name) {}

  void clearError() {
    _hasError = false;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
