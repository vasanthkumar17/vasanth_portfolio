import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/animated_fade.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final categories = <MapEntry<String, List<String>>>[
      MapEntry('Frameworks', [
        'iOS (UIKit, SwiftUI)',
        'Android',
        'Xamarin.Native (iOS & Android)',
        'Flutter',
      ]),
      MapEntry('Programming Languages', [
        'Swift',
        'Kotlin',
        'Objective-C',
        'C#',
        'Dart',
      ]),
      MapEntry('Architectures & Methodologies', [
        'MVVM',
        'MVC',
        'Dependency Injection',
        'TDD',
        'AGILE',
      ]),
      MapEntry('Databases', ['Realm', 'SQL', 'CoreData', 'Room']),
      MapEntry('Technologies & Services', [
        'Firebase',
        'Google Maps & MapKit',
        'Bluetooth Low Energy (BLE)',
        'Agora RTM',
        'WebSocket',
        'XMPP',
        'WebRTC',
      ]),
      MapEntry('Development Tools', [
        'Visual Studio',
        'Xcode',
        'Android Studio',
      ]),
    ];

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
              'Core Competencies',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.start,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child:
                  Text(
                        'Comprehensive expertise across modern mobile development platforms, architectures, and tools:',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.start,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 40),
            for (int i = 0; i < categories.length; i++) ...[
              _buildToolCategory(
                    context,
                    categories[i].key,
                    categories[i].value,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(6),
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
