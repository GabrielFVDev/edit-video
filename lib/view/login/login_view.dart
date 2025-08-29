import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_editor/viewmodel/viewmodels.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import '../widgets/buttons/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validação local primeiro (UX mais rápida)
    if (!_formKey.currentState!.validate()) return;

    final loginViewModel = context.read<LoginViewModel>();

    // Evita múltiplos cliques durante loading
    if (loginViewModel.isLoading) return;

    // Chama o ViewModel
    loginViewModel.performLogin(
      _emailController.text.trim(),
      _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, loginViewModel, child) {
        // Side effects - navegação e erros
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navegação após sucesso
          if (loginViewModel.isSuccess) {
            context.go('/home');
          }

          // Mostrar erros
          if (loginViewModel.hasError && loginViewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loginViewModel.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Fechar',
                  textColor: Colors.white,
                  onPressed: () {
                    loginViewModel.clearError();
                  },
                ),
              ),
            );
          }
        });

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Header
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.video_collection_rounded,
                            size: 40,
                            color: AppColors.foreground,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Bem-vindo!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Entre com seus dados para começar',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.foregroundSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),

                    // ✅ ESPECIALISTA: Campo Nome com validação otimizada
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: AppColors.foreground),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: AppColors.foregroundSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppColors.foregroundSecondary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        if (value.trim().length < 2) {
                          return 'Nome deve ter pelo menos 2 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ✅ ESPECIALISTA: Campo Email com validação melhorada
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: AppColors.foreground),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: AppColors.foregroundSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.foregroundSecondary,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value.trim())) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _handleLogin(),
                    ),
                    const SizedBox(height: 32),

                    // Botão de Login
                    PrimaryButton.bigRounded(
                      label: 'Entrar',
                      onPressed: _handleLogin,
                      state: loginViewModel.isLoading
                          ? StateButton.loading
                          : StateButton.success,
                    ),
                    const SizedBox(height: 24),

                    // Texto informativo
                    Text(
                      'Este é um MVP. Os dados são salvos localmente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.foreground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
