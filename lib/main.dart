import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/core/routes.dart';
import 'package:video_editor/core/constants/app_colors.dart';

void main() {
  runApp(
    // ProviderScope é necessário para usar Riverpod
    const ProviderScope(
      child: MyApp(),
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
