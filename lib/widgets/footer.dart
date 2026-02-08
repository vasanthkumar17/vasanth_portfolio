import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _openLinkedIn() async {
    const url = "https://www.linkedin.com/in/vasanth-kumar-4522a61a0/";
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("© 2026 Vasanth Kumar K"),
          const SizedBox(height: 8),

          TextButton(onPressed: _openLinkedIn, child: const Text("LinkedIn")),
        ],
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15, end: 0.0),
    );
  }
}
