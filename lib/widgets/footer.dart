import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/strings.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _openLinkedIn() async {
    final url = Uri.parse(AppStrings.linkedInUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(AppStrings.footerCopyright),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _openLinkedIn,
            child: const Text(AppStrings.footerLinkedIn),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15, end: 0.0),
    );
  }
}
