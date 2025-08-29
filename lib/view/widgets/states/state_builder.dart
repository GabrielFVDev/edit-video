import 'package:flutter/material.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/core/constants/app_view_state.dart';

/// Widget que gerencia a exibição de conteúdo baseado no estado da view
/// Similar ao padrão BlocBuilder, mas usando estados customizados
class StateBuilder<T> extends StatelessWidget {
  /// Estado atual da view
  final AppViewState<T> state;

  /// Widget a ser exibido quando há conteúdo
  final Widget Function(BuildContext context, T data) contentBuilder;

  /// Widget customizado para estado vazio (opcional)
  final Widget Function(BuildContext context)? emptyBuilder;

  /// Widget customizado para estado de carregamento (opcional)
  final Widget Function(BuildContext context)? loadingBuilder;

  /// Widget customizado para estado de erro (opcional)
  final Widget Function(BuildContext context, String error)? errorBuilder;

  /// Configurações para o estado vazio padrão
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData? emptyIcon;
  final VoidCallback? emptyAction;
  final String? emptyActionText;

  const StateBuilder({
    super.key,
    required this.state,
    required this.contentBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon,
    this.emptyAction,
    this.emptyActionText,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.state) {
      case ViewState.loading:
        return loadingBuilder?.call(context) ?? _buildDefaultLoading();

      case ViewState.empty:
        return emptyBuilder?.call(context) ?? _buildDefaultEmpty();

      case ViewState.content:
        if (state.data != null) {
          return contentBuilder(context, state.data as T);
        }
        return emptyBuilder?.call(context) ?? _buildDefaultEmpty();

      case ViewState.error:
        return errorBuilder?.call(
              context,
              state.errorMessage ?? 'Erro desconhecido',
            ) ??
            _buildDefaultError(state.errorMessage ?? 'Erro desconhecido');
    }
  }

  Widget _buildDefaultLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: 16),
          Text(
            'Carregando...',
            style: TextStyle(
              color: AppColors.foreground,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                emptyIcon ?? Icons.inbox_outlined,
                size: 60,
                color: AppColors.foregroundSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              emptyTitle ?? 'Nenhum item encontrado',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
              textAlign: TextAlign.center,
            ),
            if (emptySubtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                emptySubtitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.foregroundSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (emptyAction != null && emptyActionText != null) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: emptyAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.foreground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: Text(emptyActionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ops! Algo deu errado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.foregroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar retry
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.foreground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
