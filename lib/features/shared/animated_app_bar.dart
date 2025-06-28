import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animate_do/animate_do.dart';
import 'navigation_provider.dart';
import 'scroll_controller_provider.dart';

class AnimatedAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const AnimatedAppBar({super.key});

  @override
  ConsumerState<AnimatedAppBar> createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends ConsumerState<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isVisible = ref.watch(scrollDirectionProvider);

    // Animate based on visibility
    if (isVisible) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black12],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          /*title: FadeInLeft(
            child: const Text(
              'TR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),*/
          actions: isMobile ? null : [
            _buildNavItem(context, 'Home', 0, '/'),
            _buildNavItem(context, 'Experience', 1, '/experience'),
            _buildNavItem(context, 'Projects', 2, '/projects'),
            _buildNavItem(context, 'About', 3, '/about'),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, int index, String route) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(navigationProvider);
        final isSelected = currentIndex == index;
        
        return FadeInRight(
          delay: Duration(milliseconds: 100 * index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                ref.read(navigationProvider.notifier).state = index;
                context.go(route);
              },
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}