import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_editor/core/constants/app_colors.dart';
import 'package:video_editor/view/home/builders/builders.dart';
import 'package:video_editor/bloc/blocs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadVideos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Meus Vídeos',
          style: TextStyle(
            color: AppColors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implementar configurações
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.foreground,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is HomeError) {
              return BuilderError(
                context: context,
                state: state,
              );
            }

            if (state is HomeEmpty) {
              return BuilderEmpty();
            }

            if (state is HomeLoaded) {
              return BuilderLoaded(
                context: context,
                state: state,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/editor'),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}
