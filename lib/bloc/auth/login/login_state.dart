import 'package:video_editor/model/user/user_model.dart';

/// Estados da tela Login seguindo padrão BLoC
abstract class LoginState {
  const LoginState();
}

/// Estado inicial do login
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// Estado de carregamento durante login
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Estado de sucesso no login
class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess({
    required this.user,
  });
}

/// Estado de erro no login
class LoginError extends LoginState {
  final String message;

  const LoginError({
    required this.message,
  });
}

/// Estado de validação de formulário
class LoginValidation extends LoginState {
  final bool isEmailValid;
  final bool isNameValid;
  final bool isFormValid;

  const LoginValidation({
    required this.isEmailValid,
    required this.isNameValid,
    required this.isFormValid,
  });
}
