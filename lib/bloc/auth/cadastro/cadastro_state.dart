import 'package:video_editor/model/user/user_model.dart';

/// Estados da tela Cadastro seguindo padrão BLoC
abstract class CadastroState {
  const CadastroState();
}

class CadastroInitial extends CadastroState {
  const CadastroInitial();
}

class CadastroLoading extends CadastroState {
  final double progress;
  final String? message;

  const CadastroLoading({this.progress = 0.0, this.message});
}

class CadastroSuccess extends CadastroState {
  final UserModel user;

  const CadastroSuccess({required this.user});
}

class CadastroValidation extends CadastroState {
  final bool isEmailValid;
  final bool isNameValid;
  final bool isFormValid;

  const CadastroValidation({
    this.isEmailValid = true,
    this.isNameValid = true,
    this.isFormValid = false,
  });
}

class CadastroError extends CadastroState {
  final String message;

  const CadastroError({required this.message});
}
