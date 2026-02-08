import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
import '../widgets/animated_fade.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launchSimpleMailto() async {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.contactTitle,
              style: Theme.of(context).textTheme.displaySmall,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 10),
            Container(
                  width: 56,
                  height: 3,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(99),
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
                        AppStrings.contactIntro,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 28),
            Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _launchSimpleMailto,
                      icon: const Icon(Icons.mail),
                      label: const Text(AppStrings.mailtoSimpleLabel),
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(
                          const ClipboardData(text: AppStrings.contactEmail),
                        );
                        if (!mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.snackEmailCopied),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text(AppStrings.mailtoCopyLabel),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 500.ms, delay: 160.ms)
                .slideY(begin: 0.2, end: 0.0),
          ],
        ),
      ),
    );
  }
}
