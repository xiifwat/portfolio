import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/constants/app_strings.dart';
import '../shared/animated_app_bar.dart';
import '../shared/navigation_provider.dart';
import '../shared/scroll_controller_provider.dart';

class ExperiencePage extends ConsumerWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(navigationProvider.notifier).state = 1;
    final scrollController = ref.watch(scrollControllerProvider);
    
    // Listen to scroll changes
    scrollController.addListener(() {
      ref.read(scrollDirectionProvider.notifier)
          .updateScrollPosition(scrollController.position.pixels);
    });
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AnimatedAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0F23),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text(
                AppStrings.underDevelopment,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}