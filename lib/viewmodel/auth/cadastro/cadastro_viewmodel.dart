import 'package:flutter/material.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/model/user/user_model.dart';

/// ViewModel da tela Cadastro - usa o CadastroBloc como fonte de dados
class CadastroViewModel extends ChangeNotifier {
  final CadastroBloc _cadastroBloc;

  CadastroViewModel(this._cadastroBloc) {
    _cadastroBloc.stream.listen((_) => notifyListeners());
  }

  CadastroState get currentState => _cadastroBloc.state;

  bool get isLoading => currentState is CadastroLoading;
  bool get hasError => currentState is CadastroError;
  bool get isSuccess => currentState is CadastroSuccess;
  bool get isValidation => currentState is CadastroValidation;

  String? get errorMessage {
    final state = currentState;
    if (state is CadastroError) return state.message;
    return null;
  }

  UserModel? get user {
    final state = currentState;
    if (state is CadastroSuccess) return state.user;
    return null;
  }

  bool get isEmailValid {
    final state = currentState;
    if (state is CadastroValidation) return state.isEmailValid;
    return true;
  }

  bool get isNameValid {
    final state = currentState;
    if (state is CadastroValidation) return state.isNameValid;
    return true;
  }

  bool get isFormValid {
    final state = currentState;
    if (state is CadastroValidation) return state.isFormValid;
    return false;
  }

  // Métodos que disparam eventos no BLoC
  void performCadastro(String email, String name) {
    _cadastroBloc.add(PerformCadastro(email, name));
  }

  void validateEmail(String email) {
    _cadastroBloc.add(ValidateEmailCadastro(email));
  }

  void validateName(String name) {
    _cadastroBloc.add(ValidateNameCadastro(name));
  }

  void validateForm(String email, String name) {
    _cadastroBloc.add(ValidateFormCadastro(email, name));
  }

  void clearError() {
    _cadastroBloc.add(const ClearCadastroError());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
