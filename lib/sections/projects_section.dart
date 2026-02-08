import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/strings.dart';
import '../widgets/animated_fade.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  Project? selectedProject;

  final List<ExperienceGroup> experienceGroups = AppData.experienceGroups;

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
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: AppStrings.externalTargetBlank,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final crossAxisCount = isMobile ? 1 : 2;
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
              AppStrings.sectionProfessionalExperience,
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
                        AppStrings.sectionProfessionalExperienceIntro,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
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
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => _launchURL(AppStrings.githubUrl),
                child: const Text(AppStrings.buttonViewMoreGitHub),
              ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark
        ? const Color(0xFF151316)
        : const Color(0xFFF7EFEA);
    final cardBorder = isDark
        ? Colors.white.withAlpha(25)
        : Colors.black.withAlpha(15);

    return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 24,
              vertical: isMobile ? 20 : 24,
            ),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: cardBorder),
            ),
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
                                isSelected:
                                    selectedProject == group.projects[i],
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
                                        selectedProject ==
                                        group.projects[i + 1],
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
                  ? Colors.white.withAlpha(10)
                  : const Color(0xFFFAF4F0),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isHovered || widget.isSelected
                    ? (isDark
                          ? Colors.white.withAlpha(64)
                          : Colors.black.withAlpha(35))
                    : (isDark
                          ? Colors.white.withAlpha(28)
                          : Colors.black.withAlpha(16)),
                width: 1.2,
              ),
              boxShadow: _isHovered || widget.isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(isDark ? 77 : 20),
                        blurRadius: 16,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withAlpha(isDark ? 31 : 10),
                        blurRadius: 8,
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
          AppStrings.projectResponsibilitiesTitle,
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
                  ? Colors.white.withAlpha(12)
                  : const Color(0xFFFBF6F3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withAlpha(46)
                    : Colors.black.withAlpha(20),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(isDark ? 64 : 20),
                  blurRadius: 20,
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
    final isMobile = MediaQuery.of(context).size.width < 768;
    final chipBackground = isDark
        ? Colors.white.withAlpha(18)
        : const Color(0xFFEBDDD4);
    final chipTextColor = isDark ? Colors.white70 : const Color(0xFF5A4A42);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              group.role,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: isMobile ? 6 : 5,
              ),
              decoration: BoxDecoration(
                color: chipBackground,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                group.timeline,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: chipTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${group.company}, ${group.location}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.white70 : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
