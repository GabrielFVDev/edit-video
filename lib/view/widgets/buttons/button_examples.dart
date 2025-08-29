import 'package:flutter/material.dart';
import 'primary_button.dart';
import '../loading/custom_loading.dart';

// EXEMPLOS DE USO DO PRIMARY BUTTON COM CUSTOM LOADING
// ====================================================

class ButtonExamplesView extends StatefulWidget {
  const ButtonExamplesView({super.key});

  @override
  State<ButtonExamplesView> createState() => _ButtonExamplesViewState();
}

class _ButtonExamplesViewState extends State<ButtonExamplesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Botão com loading circular (padrão)
            const PrimaryButton(
              label: 'Fazendo Login...',
              state: ButtonState.loading,
              loadingType: LoadingType.circular,
            ),
            const SizedBox(height: 16),

            // 2. Botão com loading dots
            const PrimaryButton(
              label: 'Processando...',
              state: ButtonState.loading,
              loadingType: LoadingType.dots,
            ),
            const SizedBox(height: 16),

            // 3. Botão com loading pulse
            const PrimaryButton(
              label: 'Conectando...',
              state: ButtonState.loading,
              loadingType: LoadingType.pulse,
            ),
            const SizedBox(height: 16),

            // 4. Botão com loading bounce
            const PrimaryButton(
              label: 'Carregando...',
              state: ButtonState.loading,
              loadingType: LoadingType.bounce,
            ),
            const SizedBox(height: 16),

            // 5. Botão outline com dots loading
            const PrimaryButton.outline(
              label: 'Gravando Vídeo...',
              state: ButtonState.loading,
              loadingType: LoadingType.dots,
            ),
            const SizedBox(height: 16),

            // 6. Botão normal
            PrimaryButton(
              label: 'Entrar',
              onPressed: () {
                print('Button pressed!');
              },
            ),
            const SizedBox(height: 16),

            // 7. Botão com ícone
            PrimaryButton.icon(
              label: 'Novo Vídeo',
              icon: Icons.add,
              onPressed: () {
                print('Icon button pressed!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EXEMPLO DE USO EM UMA TELA REAL:
// ================================
/*
class LoginView extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(loginViewModelProvider.notifier)
      .login(_nameController.text, _emailController.text);
    
    if (success) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // ... campos do formulário ...
            
            // Botão com micro interação de loading
            PrimaryButton(
              label: 'Entrar',
              state: authState.isLoading ? ButtonState.loading : ButtonState.normal,
              loadingType: LoadingType.circular, // ou dots, pulse, bounce
              onPressed: authState.isLoading ? null : _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
*/

// MICRO INTERAÇÕES DISPONÍVEIS:
// =============================
/*
✅ LoadingType.circular - Loading circular tradicional
✅ LoadingType.dots - Três pontos animados (elegante)
✅ LoadingType.pulse - Efeito de pulso (suave)
✅ LoadingType.bounce - Pontos que saltam (divertido)

QUANDO USAR CADA TIPO:
- circular: Login, operações rápidas
- dots: Processamento de vídeo, uploads
- pulse: Conexões, sincronização
- bounce: Operações longas, entretenimento
*/
