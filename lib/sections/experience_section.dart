import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/strings.dart';
import '../widgets/animated_fade.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final categories = AppData.skillCategories;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark
        ? Colors.white.withAlpha(140)
        : const Color(0xFF7A5C50);

    return AnimatedFade(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 60 : 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.sectionCoreCompetencies,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 10),
            Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 56,
                    height: 3,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 80.ms)
                .slideX(begin: -0.1, end: 0.0),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child:
                  Text(
                        AppStrings.sectionCoreCompetenciesIntro,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 40),
            for (int i = 0; i < categories.length; i++) ...[
              _buildToolCategory(
                    context,
                    categories[i].title,
                    categories[i].items,
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: (220 + i * 90).ms)
                  .slideY(begin: 0.15, end: 0.0),
              if (i != categories.length - 1) const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToolCategory(
    BuildContext context,
    String category,
    List<String> tools,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipGradient = isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A2A2A), Color(0xFF1C1C1C)],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFEAEAEA)],
          );
    final chipBorder = isDark
        ? Colors.white.withAlpha(26)
        : Colors.black.withAlpha(18);
    final chipShadow = isDark
        ? Colors.black.withAlpha(80)
        : Colors.black.withAlpha(35);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          category,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: tools
              .map(
                (tool) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: chipGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: chipBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: chipShadow,
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    tool,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
