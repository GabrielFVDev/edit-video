/// Eventos que podem ser disparados na tela de Cadastro
abstract class CadastroEvent {
  const CadastroEvent();
}

/// Fazer cadastro com email e nome
class PerformCadastro extends CadastroEvent {
  final String email;
  final String name;

  const PerformCadastro(this.email, this.name);
}

/// Validar email
class ValidateEmailCadastro extends CadastroEvent {
  final String email;

  const ValidateEmailCadastro(this.email);
}

/// Validar nome
class ValidateNameCadastro extends CadastroEvent {
  final String name;

  const ValidateNameCadastro(this.name);
}

/// Validar formulário completo
class ValidateFormCadastro extends CadastroEvent {
  final String email;
  final String name;

  const ValidateFormCadastro(this.email, this.name);
}

/// Limpar estado de erro
class ClearCadastroError extends CadastroEvent {
  const ClearCadastroError();
}
