import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/core/routes.dart';

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
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 0,
        ),
      ),
    );
  }
}
