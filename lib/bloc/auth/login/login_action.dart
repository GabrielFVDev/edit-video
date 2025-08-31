/// Eventos que podem ser disparados na tela Login
abstract class LoginEvent {
  const LoginEvent();
}

/// Fazer login com email e nome
class PerformLogin extends LoginEvent {
  final String email;
  final String name;

  const PerformLogin(this.email, this.name);
}

/// Validar email
class ValidateEmail extends LoginEvent {
  final String email;

  const ValidateEmail(this.email);
}

/// Validar nome
class ValidateName extends LoginEvent {
  final String name;

  const ValidateName(this.name);
}

/// Validar formulário completo
class ValidateForm extends LoginEvent {
  final String email;
  final String name;

  const ValidateForm(this.email, this.name);
}

/// Limpar estado de erro
class ClearLoginError extends LoginEvent {
  const ClearLoginError();
}

/// Fazer logout
class Logout extends LoginEvent {
  const Logout();
}
