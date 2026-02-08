import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/resume_download.dart';
import '../constants/strings.dart';

import '../providers/theme_provider.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onProjects;
  final VoidCallback onSkills;
  final VoidCallback onContact;
  final bool isScrolled;

  const NavBar({
    super.key,
    required this.onHome,
    required this.onProjects,
    required this.onSkills,
    required this.onContact,
    this.isScrolled = false,
  });

  void _launchResume() async {
    await downloadResume();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0B0B0B), Color(0xFF1F1420), Color(0xFF0F1B2A)]
              : const [Color(0xFFF8F2F0), Color(0xFFF2D2C4), Color(0xFFD6E6F5)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          const Text(
            AppStrings.navBrand,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),

          _navItem(AppStrings.navHome, onHome),
          _navItem(AppStrings.navProjects, onProjects),
          _navItem(AppStrings.navSkills, onSkills),
          _navItem(AppStrings.navContact, onContact),

          const SizedBox(width: 16),

          // Resume Button
          ElevatedButton(
            onPressed: _launchResume,
            child: const Text(AppStrings.navResume),
          ),

          const SizedBox(width: 12),

          // Theme Toggle
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: theme.toggleTheme,
          ),
        ],
      ),
    );
  }

  Widget _navItem(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
