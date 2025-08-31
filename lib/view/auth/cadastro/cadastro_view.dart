import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_editor/viewmodel/viewmodels.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import '../../widgets/buttons/primary_button.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmEmailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _confirmEmailController.dispose();
    super.dispose();
  }

  Future<void> _handleCadastro() async {
    // Validação local primeiro (UX mais rápida)
    if (!_formKey.currentState!.validate()) return;

    final cadastroViewModel = context.read<CadastroViewModel>();

    // Evita múltiplos cliques durante loading
    if (cadastroViewModel.isLoading) return;

    // Chama o ViewModel
    cadastroViewModel.performCadastro(
      _emailController.text.trim(),
      _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CadastroViewModel>(
      builder: (context, cadastroViewModel, child) {
        // Side effects - navegação e erros
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navegação após sucesso - vai para login
          if (cadastroViewModel.isSuccess) {
            // Mostrar sucesso primeiro
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Conta criada com sucesso! Faça seu login.',
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );

            // Resetar estado do BLoC (remove LoginSuccess) antes de navegar
            cadastroViewModel.clearError();

            // Navegar para login após delay
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.go('/login');
              }
            });
          }

          // Mostrar erros
          if (cadastroViewModel.hasError &&
              cadastroViewModel.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(cadastroViewModel.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Fechar',
                  textColor: Colors.white,
                  onPressed: () => cadastroViewModel.clearError(),
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
                            Icons.person_add_rounded,
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
                          'Preencha os dados para se cadastrar',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.foregroundSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),

                    // Campo Nome
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: AppColors.foreground),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Nome completo',
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
                          return 'Por favor, insira seu nome completo';
                        }
                        if (value.trim().length < 2) {
                          return 'Nome deve ter pelo menos 2 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                    ),
                    const SizedBox(height: 16),

                    // Campo Confirmar Email
                    TextFormField(
                      controller: _confirmEmailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: AppColors.foreground),
                      decoration: InputDecoration(
                        labelText: 'Confirmar email',
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
                          return 'Por favor, confirme seu email';
                        }
                        if (value.trim() != _emailController.text.trim()) {
                          return 'Os emails não coincidem';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _handleCadastro(),
                    ),
                    const SizedBox(height: 32),

                    // Texto informativo
                    Text(
                      'Este é um MVP. Os dados são salvos localmente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.foreground,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Já tem uma conta? ',
                          style: TextStyle(
                            color: AppColors.foregroundSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Text(
                            'Fazer login',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 42),
            child: PrimaryButton.bigRounded(
              label: 'Criar Conta',
              onPressed: _handleCadastro,
              state: cadastroViewModel.isLoading
                  ? StateButton.loading
                  : StateButton.success,
            ),
          ),
        );
      },
    );
  }
}
