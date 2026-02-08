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
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(top: navBarHeight),
              child: Column(
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
