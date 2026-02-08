import 'package:flutter/material.dart';
import '../sections/projects_section.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navbar
            NavBar(
              onHome: () => Navigator.of(context).pop(),
              onProjects: () => Navigator.of(context).pop(),
              onSkills: () => Navigator.of(context).pop(),
              onContact: () => Navigator.of(context).pop(),
            ),

            // Main Content
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: isMobile ? 40 : 60,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Back to Projects',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Project Title
                    Text(
                      project.name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 32 : 48,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Technology Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withAlpha(38)
                            : Colors.black.withAlpha(26),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withAlpha(77)
                              : Colors.black.withAlpha(51),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        project.technology,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Overview Section
                    Text(
                      'Project Overview',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Key Responsibilities Section
                    Text(
                      'Key Responsibilities',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 28),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (
                          int i = 0;
                          i < project.responsibilities.length;
                          i++
                        )
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    right: 16,
                                  ),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    project.responsibilities[i],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          height: 1.6,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 60),

                    // Call to Action
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: isMobile ? 32 : 48,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withAlpha(13)
                            : Colors.black.withAlpha(13),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withAlpha(51)
                              : Colors.black.withAlpha(26),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready to work together?',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Let\'s discuss how I can help bring your project to life.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 28),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to contact section or show contact form
                            },
                            child: const Text('Get in Touch'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
