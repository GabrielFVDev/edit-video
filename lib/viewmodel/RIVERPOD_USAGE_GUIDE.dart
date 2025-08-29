// GUIA DE USO DO RIVERPOD NO PROJETO
// ====================================

/*
ESTRUTURA DOS VIEWMODELS:

1. LoginViewModel (login_viewmodel.dart)
   - Gerencia autenticação
   - Estados: AuthState
   - Providers: loginViewModelProvider, isAuthenticatedProvider, currentUserProvider

2. SplashViewModel (splash_viewmodel.dart)
   - Gerencia inicialização do app
   - Estados: SplashState
   - Provider: splashViewModelProvider

3. HomeViewModel (home_viewmodel.dart)
   - Gerencia lista de vídeos
   - Estados: HomeState
   - Providers: homeViewModelProvider, videosByStatusProvider, videoCountByStatusProvider

4. EditorViewModel (editor_viewmodel.dart)
   - Gerencia edição de vídeos
   - Estados: EditorState
   - Providers: editorViewModelProvider, hasVideoSelectedProvider, canProcessProvider
*/

// EXEMPLO DE USO NAS TELAS:
// =========================

// 1. SUBSTITUIR StatefulWidget por ConsumerStatefulWidget
// --------------------------------------------------------
/*
// ANTES:
class MyView extends StatefulWidget {
  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  // ...
}

// DEPOIS:
class MyView extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyView> createState() => _MyViewState();
}

class _MyViewState extends ConsumerState<MyView> {
  // ...
}
*/

// 2. ACESSAR ESTADO DO VIEWMODEL
// ------------------------------
/*
@override
Widget build(BuildContext context) {
  // Lê o estado atual
  final authState = ref.watch(loginViewModelProvider);
  
  // Ou usar helpers
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final currentUser = ref.watch(currentUserProvider);
  
  return Scaffold(
    body: authState.isLoading 
      ? CircularProgressIndicator()
      : Text('Bem-vindo, ${currentUser?.name}'),
  );
}
*/

// 3. CHAMAR MÉTODOS DO VIEWMODEL
// ------------------------------
/*
void _handleLogin() async {
  final success = await ref.read(loginViewModelProvider.notifier)
    .login(_nameController.text, _emailController.text);
  
  if (success) {
    context.go('/home');
  }
}
*/

// 4. ESCUTAR MUDANÇAS DE ESTADO
// -----------------------------
/*
@override
Widget build(BuildContext context) {
  // Escuta mudanças e executa ações
  ref.listen<AuthState>(loginViewModelProvider, (previous, next) {
    if (next.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.error!)),
      );
    }
    
    if (next.isAuthenticated) {
      context.go('/home');
    }
  });
  
  return YourWidget();
}
*/

// IMPLEMENTAÇÃO NAS TELAS ATUAIS:
// ===============================

// LoginView - Atualizar para usar loginViewModelProvider
// HomeView - Atualizar para usar homeViewModelProvider
// EditorView - Atualizar para usar editorViewModelProvider
// SplashView - Já atualizada como exemplo

void main() {
  print("Este arquivo é apenas um guia de referência!");
  print("Use os exemplos acima para implementar Riverpod nas suas telas.");
}
