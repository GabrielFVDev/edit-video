import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/model/user/user_model.dart';
import 'login_state.dart';
import 'login_action.dart';

/// BLoC para gerenciar estado da tela Login
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<PerformLogin>(_onPerformLogin);
    on<ValidateEmail>(_onValidateEmail);
    on<ValidateName>(_onValidateName);
    on<ValidateForm>(_onValidateForm);
    on<ClearLoginError>(_onClearLoginError);
    on<Logout>(_onLogout);
  }

  /// Handler para fazer login
  Future<void> _onPerformLogin(
    PerformLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    try {
      // Simular processo de login
      await Future.delayed(const Duration(seconds: 2));

      // Validação simples
      if (event.email.isEmpty || !event.email.contains('@')) {
        emit(const LoginError(message: 'Email inválido'));
        return;
      }

      if (event.name.length < 2) {
        emit(
          const LoginError(message: 'Nome deve ter pelo menos 2 caracteres'),
        );
        return;
      }

      // Criar usuário mockado
      final user = UserModel(
        id: '1',
        name: event.name,
        email: event.email,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      emit(LoginSuccess(user: user));
    } catch (e) {
      emit(LoginError(message: 'Erro ao fazer login: ${e.toString()}'));
    }
  }

  /// Handler para validar email
  void _onValidateEmail(ValidateEmail event, Emitter<LoginState> emit) {
    final isValid = event.email.isNotEmpty && event.email.contains('@');
    emit(
      LoginValidation(
        isEmailValid: isValid,
        isNameValid: true, // Assumir que nome já foi validado
        isFormValid: isValid,
      ),
    );
  }

  /// Handler para validar nome
  void _onValidateName(ValidateName event, Emitter<LoginState> emit) {
    final isValid = event.name.length >= 2;
    emit(
      LoginValidation(
        isEmailValid: true, // Assumir que email já foi validado
        isNameValid: isValid,
        isFormValid: isValid,
      ),
    );
  }

  /// Handler para validar formulário completo
  void _onValidateForm(ValidateForm event, Emitter<LoginState> emit) {
    final isEmailValid = event.email.isNotEmpty && event.email.contains('@');
    final isNameValid = event.name.length >= 2;
    final isFormValid = isEmailValid && isNameValid;

    emit(
      LoginValidation(
        isEmailValid: isEmailValid,
        isNameValid: isNameValid,
        isFormValid: isFormValid,
      ),
    );
  }

  /// Handler para limpar erro
  void _onClearLoginError(ClearLoginError event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
  }

  /// Handler para logout
  void _onLogout(Logout event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
  }
}
