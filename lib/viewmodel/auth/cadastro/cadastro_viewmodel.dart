import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/model/user/user_model.dart';
import 'package:video_editor/core/services/first_access_service.dart';

/// ViewModel da tela Cadastro - usa BLoC como fonte de dados
class CadastroViewModel extends ChangeNotifier {
  final LoginBloc _loginBloc; // Reutiliza o mesmo BLoC do login

  CadastroViewModel(this._loginBloc) {
    // Escutar mudanças de estado do BLoC
    _loginBloc.stream.listen((state) {
      notifyListeners();
    });
  }

  // Getters que expõem o estado do BLoC
  LoginState get currentState => _loginBloc.state;

  bool get isLoading => currentState is LoginLoading;
  bool get hasError => currentState is LoginError;
  bool get isSuccess => currentState is LoginSuccess;
  bool get isValidation => currentState is LoginValidation;

  String? get errorMessage {
    final state = currentState;
    if (state is LoginError) {
      return state.message;
    }
    return null;
  }

  UserModel? get user {
    final state = currentState;
    if (state is LoginSuccess) {
      return state.user;
    }
    return null;
  }

  bool get isEmailValid {
    final state = currentState;
    if (state is LoginValidation) {
      return state.isEmailValid;
    }
    return true; // Assume válido por padrão
  }

  bool get isNameValid {
    final state = currentState;
    if (state is LoginValidation) {
      return state.isNameValid;
    }
    return true; // Assume válido por padrão
  }

  bool get isFormValid {
    final state = currentState;
    if (state is LoginValidation) {
      return state.isFormValid;
    }
    return false;
  }

  // Métodos que disparam eventos no BLoC - mesmo comportamento do login
  Future<void> performCadastro(String email, String name) async {
    _loginBloc.add(PerformLogin(email, name)); // Reutiliza mesma lógica

    // Marcar que usuário se registrou e primeiro acesso foi completado
    await FirstAccessService.markUserRegistered();
    await FirstAccessService.markFirstAccessCompleted();
  }

  void validateEmail(String email) {
    _loginBloc.add(ValidateEmail(email));
  }

  void validateName(String name) {
    _loginBloc.add(ValidateName(name));
  }

  void validateForm(String email, String name) {
    _loginBloc.add(ValidateForm(email, name));
  }

  void clearError() {
    _loginBloc.add(const ClearLoginError());
  }

  @override
  void dispose() {
    // O BLoC é gerenciado pelo Provider no main.dart
    super.dispose();
  }
}
