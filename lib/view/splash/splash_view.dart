import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import '../../viewmodel/viewmodels.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Inicia a inicialização do app via ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().initializeApp();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
          ),
        );

    _scaleAnimation =
        Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
          ),
        );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashViewModel>(
      builder: (context, splashViewModel, child) {
        // Escuta mudanças no estado do splash para navegação
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (splashViewModel.isComplete) {
            if (splashViewModel.userLoggedIn) {
              context.go('/home');
            } else {
              context.go('/login');
            }
          } else if (splashViewModel.hasError) {
            // Mostrar erro e tentar novamente
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  splashViewModel.errorMessage ?? 'Erro desconhecido',
                ),
                backgroundColor: AppColors.error,
                action: SnackBarAction(
                  label: 'Tentar novamente',
                  onPressed: () => splashViewModel.restartSplash(),
                ),
              ),
            );
          }
        });

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo/Ícone principal
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6366F1).withAlpha(3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.video_collection_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Título
                        const Text(
                          'VideoEditor',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtítulo
                        Text(
                          'Editor de vídeo com IA',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(7),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Loading indicator
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withAlpha(7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
