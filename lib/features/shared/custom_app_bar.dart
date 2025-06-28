import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animate_do/animate_do.dart';
import 'navigation_provider.dart';

// Custom App Bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return Container(
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
        title: FadeInLeft(
          child: const Text(
            'TR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: isMobile ? null : [
          _buildNavItem(context, 'Home', 0, '/'),
          _buildNavItem(context, 'Experience', 1, '/experience'),
          _buildNavItem(context, 'Projects', 2, '/projects'),
          _buildNavItem(context, 'About', 3, '/about'),
          const SizedBox(width: 20),
        ],
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}