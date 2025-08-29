/// Enumeração para representar os diferentes estados de uma tela
enum ViewState {
  /// Estado inicial/carregando
  loading,

  /// Estado quando não há dados para exibir
  empty,

  /// Estado quando há dados para exibir
  content,

  /// Estado quando ocorreu um erro
  error,
}

/// Classe para representar o estado de uma view com dados opcionais
class AppViewState<T> {
  final ViewState state;
  final T? data;
  final String? errorMessage;
  final bool isLoading;

  const AppViewState({
    required this.state,
    this.data,
    this.errorMessage,
    this.isLoading = false,
  });

  /// Factory constructor para estado de carregamento
  factory AppViewState.loading() {
    return const AppViewState(
      state: ViewState.loading,
      isLoading: true,
    );
  }

  /// Factory constructor para estado vazio
  factory AppViewState.empty() {
    return const AppViewState(
      state: ViewState.empty,
    );
  }

  /// Factory constructor para estado com conteúdo
  factory AppViewState.content(T data) {
    return AppViewState(
      state: ViewState.content,
      data: data,
    );
  }

  /// Factory constructor para estado de erro
  factory AppViewState.error(String message) {
    return AppViewState(
      state: ViewState.error,
      errorMessage: message,
    );
  }

  /// Verifica se o estado atual é de carregamento
  bool get isLoadingState => state == ViewState.loading || isLoading;

  /// Verifica se o estado atual é vazio
  bool get isEmptyState => state == ViewState.empty;

  /// Verifica se o estado atual tem conteúdo
  bool get hasContent => state == ViewState.content && data != null;

  /// Verifica se o estado atual é de erro
  bool get hasError => state == ViewState.error;
}
