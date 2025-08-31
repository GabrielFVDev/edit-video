import 'package:flutter_bloc/flutter_bloc.dart';
import 'cadastro_state.dart';
import 'cadastro_action.dart';
import 'package:video_editor/model/user/user_model.dart';

/// BLoC para gerenciar estado da tela Cadastro
class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(const CadastroInitial()) {
    on<PerformCadastro>(_onPerformCadastro);
    on<ValidateEmailCadastro>(_onValidateEmail);
    on<ValidateNameCadastro>(_onValidateName);
    on<ValidateFormCadastro>(_onValidateForm);
    on<ClearCadastroError>(_onClearCadastroError);
  }

  Future<void> _onPerformCadastro(
    PerformCadastro event,
    Emitter<CadastroState> emit,
  ) async {
    emit(const CadastroLoading());

    try {
      // Simular processo de cadastro
      await Future.delayed(const Duration(seconds: 2));

      // Validações simples
      if (event.email.isEmpty || !event.email.contains('@')) {
        emit(const CadastroError(message: 'Email inválido'));
        return;
      }

      if (event.name.length < 2) {
        emit(
          const CadastroError(message: 'Nome deve ter pelo menos 2 caracteres'),
        );
        return;
      }

      // Criar usuário mockado
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        email: event.email,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      emit(CadastroSuccess(user: user));
    } catch (e) {
      emit(CadastroError(message: 'Erro ao criar conta: ${e.toString()}'));
    }
  }

  void _onValidateEmail(
    ValidateEmailCadastro event,
    Emitter<CadastroState> emit,
  ) {
    final isValid = event.email.isNotEmpty && event.email.contains('@');
    emit(
      CadastroValidation(
        isEmailValid: isValid,
        isNameValid: true,
        isFormValid: isValid,
      ),
    );
  }

  void _onValidateName(
    ValidateNameCadastro event,
    Emitter<CadastroState> emit,
  ) {
    final isValid = event.name.length >= 2;
    emit(
      CadastroValidation(
        isEmailValid: true,
        isNameValid: isValid,
        isFormValid: isValid,
      ),
    );
  }

  void _onValidateForm(
    ValidateFormCadastro event,
    Emitter<CadastroState> emit,
  ) {
    final isEmailValid = event.email.isNotEmpty && event.email.contains('@');
    final isNameValid = event.name.length >= 2;
    final isFormValid = isEmailValid && isNameValid;

    emit(
      CadastroValidation(
        isEmailValid: isEmailValid,
        isNameValid: isNameValid,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onClearCadastroError(
    ClearCadastroError event,
    Emitter<CadastroState> emit,
  ) {
    emit(const CadastroInitial());
  }
}
