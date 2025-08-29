import 'package:flutter/material.dart';
import 'package:video_editor/core/routes.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EditorView',
      routerConfig: router,
    );
  }
}
