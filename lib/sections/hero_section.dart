import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/strings.dart';
import '../utils/resume_download.dart';
import '../widgets/animated_fade.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, this.onViewProjects});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: AppStrings.externalTargetBlank,
      );
    }
  }

  Future<void> _launchMailto() async {
    final mailto = Uri(
      scheme: AppStrings.mailtoScheme,
      path: AppStrings.contactEmail,
    );
    if (await canLaunchUrl(mailto)) {
      await launchUrl(
        mailto,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: AppStrings.externalTargetSelf,
      );
    }
  }

  Future<void> _launchResume() async {
    await downloadResume();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
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
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: _HeroContent(
          accentColor: accentColor,
          isMobile: isMobile,
          onLaunchMailto: _launchMailto,
          onLaunchResume: _launchResume,
          onLaunchUrl: _launchURL,
          onViewProjects: onViewProjects,
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final Color accentColor;
  final bool isMobile;
  final Future<void> Function() onLaunchMailto;
  final Future<void> Function() onLaunchResume;
  final Future<void> Function(String) onLaunchUrl;
  final VoidCallback? onViewProjects;

  const _HeroContent({
    required this.accentColor,
    required this.isMobile,
    required this.onLaunchMailto,
    required this.onLaunchResume,
    required this.onLaunchUrl,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.heroGreeting,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextSpan(
                text: AppStrings.heroSparkle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0.0),
        const SizedBox(height: 16),
        Text(
              AppStrings.heroRole,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 120.ms)
            .slideY(begin: 0.2, end: 0.0),
        const SizedBox(height: 14),
        Container(
              width: 56,
              height: 3,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(99),
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 160.ms)
            .slideX(begin: -0.1, end: 0.0),
        const SizedBox(height: 22),
        SizedBox(
          width: isMobile ? double.infinity : 550,
          child:
              Text(
                    AppStrings.heroSummary,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.6),
                    textAlign: TextAlign.start,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 240.ms)
                  .slideY(begin: 0.2, end: 0.0),
        ),
        const SizedBox(height: 40),
        Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                if (isMobile)
                  ElevatedButton(
                    onPressed: onLaunchResume,
                    child: const Text(AppStrings.navResume),
                  ),
                ElevatedButton(
                  onPressed: onLaunchMailto,
                  child: const Text(AppStrings.buttonContactMe),
                ),
                OutlinedButton(
                  onPressed: onViewProjects,
                  child: const Text(AppStrings.buttonViewProjects),
                ),
                OutlinedButton.icon(
                  onPressed: () => onLaunchUrl(AppStrings.githubUrl),
                  icon: const Icon(Icons.link, size: 18),
                  label: const Text(AppStrings.buttonGitHub),
                ),
                OutlinedButton.icon(
                  onPressed: () => onLaunchUrl(AppStrings.linkedInUrl),
                  icon: const Icon(Icons.link, size: 18),
                  label: const Text(AppStrings.buttonLinkedIn),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: 360.ms)
            .slideY(begin: 0.2, end: 0.0),
      ],
    );
  }
}
