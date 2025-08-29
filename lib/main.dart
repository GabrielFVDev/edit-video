import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_editor/core/config/routes.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/bloc/blocs.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider para BLoC da tela Home
        BlocProvider(
          create: (_) => HomeBloc(),
        ),
        // BlocProvider para BLoC da tela Login
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        // BlocProvider para BLoC da tela Splash
        BlocProvider(
          create: (_) => SplashBloc(),
        ),
        // BlocProvider para BLoC da tela Editor
        BlocProvider(
          create: (_) => EditorBloc(),
        ),
      ],
      child: const MyApp(),
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
        // Configuração de tema escuro para combinar com as telas
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
