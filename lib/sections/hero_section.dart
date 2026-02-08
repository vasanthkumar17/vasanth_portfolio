import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_fade.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, this.onViewProjects});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedFade(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 60 : 80,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hey, I'm Vasanth Kumar K ",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  TextSpan(
                    text: '✨',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 16),
            Text(
                  'Mobile App Developer',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 120.ms)
                .slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 32),
            SizedBox(
              width: isMobile ? double.infinity : 550,
              child:
                  Text(
                        'Mobile app developer with over 4.8 years of experience in Xamarin Native, iOS, and Android app development. Skilled in push notifications, Bluetooth Low Energy (BLE), Agora RTM, and app store/play store submission processes. Currently expanding expertise by learning Flutter Experienced across all stages of the Software Development Life Cycle (SDLC), from requirements analysis to deployment and documentation. Proven ability to develop apps from scratch through to production release.',
                        style: Theme.of(context).textTheme.bodyLarge,
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
                    ElevatedButton(
                      onPressed: () =>
                          _launchURL('mailto:vasanthkumar04398@example.com'),
                      child: const Text('Contact Me'),
                    ),
                    OutlinedButton(
                      onPressed: onViewProjects,
                      child: const Text('View Projects'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () =>
                          _launchURL('https://github.com/vasanthkumar17'),
                      icon: const Icon(Icons.link, size: 18),
                      label: const Text('GitHub'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _launchURL(
                        'https://www.linkedin.com/in/vasanth-kumar-4522a61a0',
                      ),
                      icon: const Icon(Icons.link, size: 18),
                      label: const Text('LinkedIn'),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: 360.ms)
                .slideY(begin: 0.2, end: 0.0),
          ],
        ),
      ),
    );
  }
}
