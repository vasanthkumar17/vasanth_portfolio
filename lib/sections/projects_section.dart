import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/animated_fade.dart';

class Project {
  final String name;
  final String technology;
  final String description;
  final List<String> responsibilities;

  Project({
    required this.name,
    required this.technology,
    required this.description,
    required this.responsibilities,
  });
}

class ExperienceGroup {
  final String company;
  final String role;
  final String location;
  final String timeline;
  final List<Project> projects;

  ExperienceGroup({
    required this.company,
    required this.role,
    required this.location,
    required this.timeline,
    required this.projects,
  });
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  Project? selectedProject;

  final List<ExperienceGroup> experienceGroups = [
    ExperienceGroup(
      company: 'Flyersoft pvt ltd',
      role: 'Software Engineer - Mobile',
      location: 'Chennai',
      timeline: 'February 2022 - Present',
      projects: [
        Project(
          name: 'C3PAY',
          technology: 'Xamarin.iOS & Xamarin.Android',
          description:
              'C3PAY (Xamarin.iOS & Xamarin.Android) is a mobile app for managing financial transactions, primarily designed for users with a C3Pay card. It allows users to view balances, send money, recharge mobile numbers, and receive SMS alerts.',
          responsibilities: [
            'Contributed to multiple modules, including C3Pay+, Mobile Recharge, and Money Transfer, Security SMS.',
            'Conducted user experiments and analyzed the impact of new features to enhance user experience.',
            'Participated in design reviews, UX discussions, and product ideation sessions.',
            'Developed dynamic UI screens for the Money Transfer flow (Bank Transfer and Wallet) based on API responses.',
            'Worked in an Agile development environment, collaborating with cross-functional teams.',
            'Started contributing to the Flutter migration, focusing on developing and optimizing UI components.',
          ],
        ),
        Project(
          name: 'XR COMPANION',
          technology: 'Android (Kotlin)',
          description:
              'XR COMPANION (Android - kotlin) helps to connect with a moziwear device. This device helps workers wear a glass and operate everything in voice over. This project is still under development.',
          responsibilities: [
            'Designed and developed agora RTM, white board with Back-end API integration and RESTFUL services.',
            'I worked with MVVM.',
            'Used Hilt Dependency injection.',
            'Used Room for database.',
            'Drawing Annotations.',
          ],
        ),
        Project(
          name: 'USEEBP',
          technology: 'Android (Kotlin)',
          description:
              'USEEBP (Android - kotlin) is a healthcare application which helps you to check BP, connect to nearby BLE devices and communicate with doctors via emails. It has a built-in chatbot functionality and helps to keep track of patient BP data and challenges.',
          responsibilities: [
            'Designed and developed chatbot features using Back-end API integration and RESTFUL services.',
            'I worked with BLE.',
            'Used Unity for Dependency Injection.',
            'I worked with MVVM.',
            'Bug fixing.',
          ],
        ),
        Project(
          name: 'DEVERON',
          technology: 'iPadOS (Swift UI)',
          description:
              'DEVERON (iPadOS - Swift UI) is a collection of soil and analysis app which help to support you with local experts to get the most out of your soil. Our single chain of custody - from field to lab - will ensure a streamlined process resulting in operational effectiveness and more efficient farm outcomes.',
          responsibilities: [
            'Designed and developed apps with Map Kit and Google Maps.',
            'I worked with SQLite.',
            'Developed library for managing Grid Layout for maps.',
            'Collaborated with the team and supported written standard code.',
            'Developed a custom UI component.',
          ],
        ),
      ],
    ),
    ExperienceGroup(
      company: 'Contus Support Interactive',
      role: 'Application Developer',
      location: 'Chennai',
      timeline: 'April 2021 - September 2021',
      projects: [
        Project(
          name: 'WONET',
          technology: 'iOS (Swift)',
          description:
              'WONET (iOS, Swift) is a leading mobile App with a friendly experience for chat, voice, and video communication in a highly secure way. It uses highly secured protocols to ensure highly secured and private communication among its users.',
          responsibilities: [
            'Designed and developed with two phases of tasks and successfully submitted to the App store.',
            'Integrated with signal protocol to send a secured encrypted and decrypted message.',
            'Worked on XMPP and WebRTC.',
            'Revamped the major feature code.',
            'Developed UI components.',
            'Bug fixing.',
            'Worked with push notification.',
          ],
        ),
      ],
    ),
    ExperienceGroup(
      company: 'W2S Solutions',
      role: 'iOS Developer',
      location: 'Chennai',
      timeline: 'February 2020 - March 2021',
      projects: [
        Project(
          name: 'MANAGETEAMZ DELIVERY',
          technology: 'iOS (Objective C)',
          description:
              'MANAGETEAMZ DELIVERY (iOS - Objective C) is a delivery management application where the delivery agent views the assigned tasks to deliver products to the customer at their location. It uses an optimized route for navigation to the customer location and gets acknowledgment for the delivered product from the customer. It has a web dashboard which enables the business owner to manage his delivery agents and keep track of their location.',
          responsibilities: [
            'Designed and developed one to one chat features using WebSocket with Back-end API integration and RESTFUL services.',
            'Support to develop core features with Google Map API and Google Place API.',
            'Integrated Phone number authentication with firebase.',
            'Implemented with MVVM design architecture.',
            'Bug fixing.',
          ],
        ),
      ],
    ),
  ];

  void _toggleProject(Project project) {
    setState(() {
      if (selectedProject == project) {
        selectedProject = null;
        return;
      }
      selectedProject = project;
    });
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final crossAxisCount = isMobile ? 1 : 2;

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
              'Professional Experience',
              style: Theme.of(context).textTheme.displaySmall,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 16),
            SizedBox(
              width: isMobile ? double.infinity : 600,
              child:
                  Text(
                        'Project details grouped by company and timeline.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 120.ms)
                      .slideY(begin: 0.2, end: 0.0),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                for (int g = 0; g < experienceGroups.length; g++)
                  _buildExperienceGroup(
                    context,
                    experienceGroups[g],
                    g,
                    isMobile,
                    crossAxisCount,
                  ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _launchURL('https://github.com/vasanthkumar17'),
              child: const Text('View More on GitHub'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceGroup(
    BuildContext context,
    ExperienceGroup group,
    int index,
    bool isMobile,
    int crossAxisCount,
  ) {
    return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ExperienceHeader(group: group),
              const SizedBox(height: 20),
              for (int i = 0; i < group.projects.length; i += crossAxisCount)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ProjectTitleTile(
                              project: group.projects[i],
                              isSelected: selectedProject == group.projects[i],
                              onTap: () => _toggleProject(group.projects[i]),
                            ),
                          ),
                          if (!isMobile) ...[
                            const SizedBox(width: 20),
                            if (i + 1 < group.projects.length)
                              Expanded(
                                child: _ProjectTitleTile(
                                  project: group.projects[i + 1],
                                  isSelected:
                                      selectedProject == group.projects[i + 1],
                                  onTap: () =>
                                      _toggleProject(group.projects[i + 1]),
                                ),
                              )
                            else
                              const Expanded(child: SizedBox.shrink()),
                          ],
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: _RowExpandedPanel(
                          project: _selectedProjectForRow(
                            group,
                            i,
                            crossAxisCount,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 550.ms, delay: (180 + index * 120).ms)
        .slideY(begin: 0.15, end: 0.0);
  }

  Project? _selectedProjectForRow(
    ExperienceGroup group,
    int index,
    int crossAxisCount,
  ) {
    if (selectedProject == null) {
      return null;
    }

    if (selectedProject == group.projects[index]) {
      return selectedProject;
    }

    if (crossAxisCount == 2 && index + 1 < group.projects.length) {
      if (selectedProject == group.projects[index + 1]) {
        return selectedProject;
      }
    }

    return null;
  }
}

class _ProjectTitleTile extends StatefulWidget {
  final Project project;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProjectTitleTile({
    required this.project,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ProjectTitleTile> createState() => _ProjectTitleTileState();
}

class _ProjectTitleTileState extends State<_ProjectTitleTile>
    with TickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: widget.isSelected ? 18 : 12,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(13)
                  : Colors.white.withAlpha(153),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isHovered || widget.isSelected
                    ? (isDark
                          ? Colors.white.withAlpha(89)
                          : Colors.black.withAlpha(51))
                    : (isDark
                          ? Colors.white.withAlpha(38)
                          : Colors.black.withAlpha(20)),
                width: 1.2,
              ),
              boxShadow: _isHovered || widget.isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(isDark ? 77 : 20),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withAlpha(isDark ? 31 : 10),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.project.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: widget.isSelected ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutCubic,
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.project.technology,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectDetailsContent extends StatelessWidget {
  final Project project;
  final bool isDark;

  const _ProjectDetailsContent({required this.project, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white70 : Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Roles & Responsibilities',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        for (final item in project.responsibilities)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 10),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RowExpandedPanel extends StatelessWidget {
  final Project? project;

  const _RowExpandedPanel({required this.project});

  @override
  Widget build(BuildContext context) {
    if (project == null) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        scale: 1.0,
        alignment: Alignment.topCenter,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: 1.0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withAlpha(15)
                  : Colors.white.withAlpha(179),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withAlpha(51)
                    : Colors.black.withAlpha(31),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDark ? 64 : 20),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: _ProjectDetailsContent(project: project!, isDark: isDark),
          ),
        ),
      ),
    );
  }
}

class _ExperienceHeader extends StatelessWidget {
  final ExperienceGroup group;

  const _ExperienceHeader({required this.group});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.role,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          '${group.company}, ${group.location}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.white70 : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          group.timeline,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
