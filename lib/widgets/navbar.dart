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
    final isMobile = MediaQuery.of(context).size.width < 900;

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
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 14 : 16,
      ),
      child: Row(
        children: [
          const Text(
            AppStrings.navBrand,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _openMobileMenu(context, theme),
            )
          else ...[
            _navItem(AppStrings.navHome, onHome),
            _navItem(AppStrings.navSkills, onSkills),
            _navItem(AppStrings.navProjects, onProjects),
            _navItem(AppStrings.navContact, onContact),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _launchResume,
              child: const Text(AppStrings.navResume),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: theme.toggleTheme,
            ),
          ],
        ],
      ),
    );
  }

  void _openMobileMenu(BuildContext context, ThemeProvider theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              20,
              16,
              20,
              16 + MediaQuery.of(sheetContext).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      AppStrings.navBrand,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _mobileNavItem(
                  sheetContext,
                  label: AppStrings.navHome,
                  onTap: onHome,
                ),
                _mobileNavItem(
                  sheetContext,
                  label: AppStrings.navSkills,
                  onTap: onSkills,
                ),
                _mobileNavItem(
                  sheetContext,
                  label: AppStrings.navProjects,
                  onTap: onProjects,
                ),
                _mobileNavItem(
                  sheetContext,
                  label: AppStrings.navContact,
                  onTap: onContact,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      _launchResume();
                    },
                    child: const Text(AppStrings.navResume),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    theme.toggleTheme();
                  },
                  icon: const Icon(Icons.brightness_6),
                  label: const Text(AppStrings.navToggleTheme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mobileNavItem(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
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
