import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:video_editor/core/config/routes.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'package:video_editor/viewmodel/viewmodels.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProviders para BLoCs
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => EditorBloc()),
        BlocProvider(create: (_) => CadastroBloc()),
      ],
      child: MultiProvider(
        providers: [
          // ChangeNotifierProviders para ViewModels
          ChangeNotifierProvider(
            create: (context) => HomeViewModel(context.read<HomeBloc>()),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginViewModel(context.read<LoginBloc>()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                CadastroViewModel(context.read<CadastroBloc>()),
          ),
          ChangeNotifierProvider(
            create: (context) => EditorViewModel(context.read<EditorBloc>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VideoEditor',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
      ),
    );
  }
}
