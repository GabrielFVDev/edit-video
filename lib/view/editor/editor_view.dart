import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:video_editor/bloc/blocs.dart';
import 'dart:io';
import 'widgets/widgets.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer(String videoPath) {
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(File(videoPath))
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {});
            }
          })
          .catchError((error) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar vídeo: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditorBloc, EditorState>(
      listener: (context, state) {
        if (state is EditorVideoLoaded) {
          _initializeVideoPlayer(state.videoPath);
        } else if (state is EditorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1A1A1A),
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/home'),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              'Editor de Vídeo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              if (state is EditorVideoLoaded && state is! EditorProcessing)
                TextButton(
                  onPressed: () =>
                      context.read<EditorBloc>().add(const StartProcessing()),
                  child: const Text(
                    'PROCESSAR',
                    style: TextStyle(
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(EditorState state) {
    if (state is EditorInitial || state is EditorVideoSelecting) {
      return EditorInitialWidget(state: state);
    } else if (state is EditorVideoLoaded || state is EditorProcessing) {
      return EditorVideoLoadedWidget(
        state: state,
        videoController: _videoController,
      );
    } else if (state is EditorError) {
      return EditorErrorWidget(state: state);
    }
    return const SizedBox.shrink();
  }
}

class EditorInitialWidget extends StatelessWidget {
  final EditorState state;

  const EditorInitialWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(1),
                  width: 2,
                ),
              ),
              child: Icon(
                state is EditorVideoSelecting
                    ? Icons.hourglass_empty
                    : Icons.video_call_outlined,
                size: 60,
                color: Colors.white.withAlpha(7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              state is EditorVideoSelecting
                  ? 'Selecionando vídeo...'
                  : 'Selecione um vídeo',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state is EditorVideoSelecting
                  ? 'Aguarde enquanto selecionamos seu vídeo'
                  : 'Escolha um vídeo da galeria ou grave um novo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(7),
              ),
            ),
            if (state is! EditorVideoSelecting) ...[
              const SizedBox(height: 48),
              const EditorActionButtons(),
            ],
          ],
        ),
      ),
    );
  }
}
