import 'package:flutter/material.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final scrolled = _scrollController.offset > 8;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const navBarHeight = 88.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [
                          Color(0xFF0B0B0B),
                          Color(0xFF1F1420),
                          Color(0xFF0F1B2A),
                        ]
                      : const [
                          Color(0xFFF8F2F0),
                          Color(0xFFF2D2C4),
                          Color(0xFFD6E6F5),
                        ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: _ParallaxDecorations(
                controller: _scrollController,
                isDark: isDark,
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(top: navBarHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeroSection(
                    key: _heroKey,
                    onViewProjects: () => _scrollToSection(_projectsKey),
                  ),
                  ExperienceSection(key: _skillsKey),
                  ProjectsSection(key: _projectsKey),
                  ContactSection(key: _contactKey),
                  const Footer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: NavBar(
                isScrolled: _isScrolled,
                onHome: () => _scrollToSection(_heroKey),
                onProjects: () => _scrollToSection(_projectsKey),
                onSkills: () => _scrollToSection(_skillsKey),
                onContact: () => _scrollToSection(_contactKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParallaxDecorations extends StatelessWidget {
  final ScrollController controller;
  final bool isDark;

  const _ParallaxDecorations({required this.controller, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final offset = controller.hasClients ? controller.offset : 0.0;
        final topShift = offset * 0.08;
        final midShift = offset * 0.12;
        final bottomShift = offset * 0.05;

        return Stack(
          children: [
            Positioned(
              top: -80 + topShift,
              right: -90,
              child: _DecorCircle(
                size: 240,
                color: isDark
                    ? const Color(0xFF2B201A).withAlpha(120)
                    : const Color(0xFFF4D6C7).withAlpha(180),
              ),
            ),
            Positioned(
              top: 320 + midShift,
              left: -100,
              child: _DecorCircle(
                size: 260,
                color: isDark
                    ? const Color(0xFF1E2733).withAlpha(110)
                    : const Color(0xFFD9E6F5).withAlpha(180),
              ),
            ),
            Positioned(
              bottom: -120 + bottomShift,
              right: -60,
              child: _DecorCircle(
                size: 220,
                color: isDark
                    ? const Color(0xFF1F1A24).withAlpha(110)
                    : const Color(0xFFEBDDD4).withAlpha(170),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DecorCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withAlpha(0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
