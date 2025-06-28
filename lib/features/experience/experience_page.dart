import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/constants/app_colors.dart';
import '../shared/animated_app_bar.dart';
import '../shared/navigation_provider.dart';
import '../shared/scroll_controller_provider.dart';

class ExperienceItem {
  final String year;
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  ExperienceItem({
    required this.year,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}

class ExperiencePage extends ConsumerStatefulWidget {
  const ExperiencePage({super.key});

  @override
  ConsumerState<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends ConsumerState<ExperiencePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<ExperienceItem> experiences = [
    ExperienceItem(
      year: '2020',
      title: 'Junior Developer',
      description: 'Started my journey as a junior developer, learning the fundamentals of mobile app development and working on small projects.',
      color: const Color(0xFFE74C3C),
      icon: Icons.school,
    ),
    ExperienceItem(
      year: '2021',
      title: 'Mobile Developer',
      description: 'Transitioned to mobile development, specializing in Android native development with Java and Kotlin.',
      color: const Color(0xFFF39C12),
      icon: Icons.phone_android,
    ),
    ExperienceItem(
      year: '2022',
      title: 'Flutter Developer',
      description: 'Expanded expertise to cross-platform development with Flutter, building apps for both iOS and Android.',
      color: const Color(0xFF3498DB),
      icon: Icons.flutter_dash,
    ),
    ExperienceItem(
      year: '2023',
      title: 'Senior Developer',
      description: 'Promoted to senior role, leading development teams and architecting complex mobile applications.',
      color: const Color(0xFF27AE60),
      icon: Icons.engineering,
    ),
    ExperienceItem(
      year: '2024',
      title: 'Lead Engineer',
      description: 'Currently serving as Lead Software Engineer, mentoring teams and driving technical excellence in mobile development.',
      color: const Color(0xFF9B59B6),
      icon: Icons.star,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(navigationProvider.notifier).state = 1;
    final scrollController = ref.watch(scrollControllerProvider);
    
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
              AppColors.gradientStart,
              AppColors.gradientMiddle,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(top: 120, bottom: 40),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        // Title
                        const Text(
                          'My Journey',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Professional Experience Timeline',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 60),
                        // Timeline
                        _buildTimeline(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    
    if (isDesktop) {
      return _buildHorizontalTimeline();
    } else if (isTablet) {
      return _buildTabletTimeline();
    } else {
      return _buildMobileTimeline();
    }
  }

  Widget _buildHorizontalTimeline() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Timeline line and markers
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                // Timeline line
                Positioned(
                  top: 100,
                  left: 60,
                  right: 60,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: experiences.map((e) => e.color).toList(),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Timeline markers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: experiences.asMap().entries.map((entry) {
                    final index = entry.key;
                    final experience = entry.value;
                    return _buildTimelineMarker(experience, index);
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Experience cards
          Row(
            children: experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final experience = entry.value;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildExperienceCard(experience, index),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletTimeline() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final experience = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                _buildTimelineMarker(experience, index),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildExperienceCard(experience, index),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileTimeline() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final experience = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                _buildTimelineMarker(experience, index),
                const SizedBox(height: 15),
                _buildExperienceCard(experience, index),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimelineMarker(ExperienceItem experience, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (index * 200)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: experience.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: experience.color.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  experience.icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: experience.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: experience.color.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  experience.year,
                  style: TextStyle(
                    color: experience.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceCard(ExperienceItem experience, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000 + (index * 150)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.overlayColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: experience.color.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: experience.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    experience.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}