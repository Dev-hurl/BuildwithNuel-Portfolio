import 'package:buildwithnuel/core/utils/launch_url.dart';
import 'package:buildwithnuel/core/widgets/engineering_stack.dart';
import 'package:buildwithnuel/core/widgets/live_demo_modal.dart';
import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../about/about_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHero(context, textTheme),
              SizedBox(height: 80),
              _buildWhoIAmCard(context, textTheme),
              SizedBox(height: 80),
              EngineeringStackSection(),
              _WorkExperienceSection(),
              SizedBox(height: 80),
              _ProjectsSection(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, TextTheme textTheme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 8, color: AppColors.success),
              const SizedBox(width: 8),
              Text(
                'Available for freelance work',
                style: TextStyle(
                  fontFamily: AppFonts.body,
                  fontSize: AppFonts.captionSize,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text.rich(
          TextSpan(
            style: textTheme.headlineMedium,
            children: [
              const TextSpan(text: 'Building Flutter apps '),
              TextSpan(
                text: 'that feel right.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Flutter developer & UX/UI designer building apps across fintech, SaaS, and productivity.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/projects'),
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(
                'View Projects',
                style: textTheme.labelLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppFonts.subheadingWeight,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/contact'),
              icon: const Icon(Icons.mail_outline, size: 18),
              label: const Text('Get in Touch'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWhoIAmCard(BuildContext context, TextTheme textTheme) {
    return _GlowBentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHO I AM',
            style: TextStyle(
              fontFamily: AppFonts.body,
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: textTheme.headlineMedium,
              children: [
                const TextSpan(text: 'Full Stack\n'),
                TextSpan(
                  text: 'Engineer\n',
                  style: TextStyle(color: AppColors.success),
                ),
                const TextSpan(text: 'Motion UI\n'),
                const TextSpan(text: 'Premium\n'),
                TextSpan(
                  text: 'Design',
                  style: TextStyle(color: AppColors.success),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Turning code into experiences you feel, remember, and can't stop coming back to.",
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// ── EXPERIENCE SECTION ──────────────────────────────────────

class _WorkExperienceSection extends StatelessWidget {
  const _WorkExperienceSection();
  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > _wideBreakpoint;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              eyebrow: 'EXPERIENCE',
              title: "Where I've ",
              highlight: 'shipped',
            ),
            const SizedBox(height: 24),
            if (isWide) _buildGrid(constraints.maxWidth) else _buildStack(),
          ],
        );
      },
    );
  }

  Widget _buildGrid(double maxWidth) {
    const spacing = 16.0;
    const columns = 2;
    final cardWidth = (maxWidth - spacing * (columns - 1)) / columns;

    final rows = <List<WorkExperience>>[];
    for (var i = 0; i < workExperience.length; i += columns) {
      rows.add(workExperience.skip(i).take(columns).toList());
    }

    return Column(
      children: rows.map((rowItems) {
        return Padding(
          padding: EdgeInsets.only(bottom: rowItems == rows.last ? 0 : spacing),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < rowItems.length; i++) ...[
                  SizedBox(
                    width: cardWidth,
                    child: _WorkExperienceCard(experience: rowItems[i]),
                  ),
                  if (i != rowItems.length - 1) const SizedBox(width: spacing),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStack() {
    return Column(
      children: workExperience
          .map(
            (exp) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _WorkExperienceCard(experience: exp),
            ),
          )
          .toList(),
    );
  }
}

class _WorkExperienceCard extends StatelessWidget {
  final WorkExperience experience;
  const _WorkExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final trimmed = experience.company.trim();
    final initials = trimmed.isEmpty
        ? '?'
        : trimmed.substring(0, trimmed.length >= 2 ? 2 : 1).toUpperCase();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.25),
                  ),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(experience.company, style: textTheme.bodyMedium),
                    Text(experience.role, style: textTheme.labelMedium),
                    SizedBox(height: 6),
                    Text(experience.period, style: textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.border, height: 6),
          const SizedBox(height: 16),
          ...experience.highlights.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 4,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(point, style: textTheme.labelMedium)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── PROJECTS SECTION ────────────────────────────────────────

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();
  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > _wideBreakpoint;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(
              eyebrow: 'PROJECTS',
              title: "Things I've ",
              highlight: 'built',
            ),
            const SizedBox(height: 24),
            if (isWide) _buildGrid(constraints.maxWidth) else _buildStack(),
          ],
        );
      },
    );
  }

  Widget _buildGrid(double maxWidth) {
    const spacing = 16.0;
    const columns = 3;
    final cardWidth = (maxWidth - spacing * (columns - 1)) / columns;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: projects
          .map(
            (p) => SizedBox(
              width: cardWidth,
              child: _ProjectGridCard(project: p),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStack() {
    return Column(
      children: projects
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProjectGridCard(project: p),
            ),
          )
          .toList(),
    );
  }
}

class _ProjectGridCard extends StatelessWidget {
  final ProjectModel project;
  const _ProjectGridCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => context.go('/projects/${project.slug}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface, //TODO: adjust
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                color: AppColors.surfaceVariant,
                child: project.screenshotUrls.isNotEmpty
                    ? Image.asset(
                        project.screenshotUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 28,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedImage02,
                          size: 28,
                          color: AppColors.textSecondary,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.techStack.isNotEmpty
                        ? project.techStack.join(' · ').toUpperCase()
                        : 'PROJECT',
                    style: textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    project.title,
                    style: textTheme.labelLarge?.copyWith(
                      fontFamily: AppFonts.heading,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(color: AppColors.border, height: 1),
                  SizedBox(height: 16),
                  Text(
                    project.tagline,
                    style: textTheme.labelMedium,
                    maxLines: 3,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      if (project.repoUrl != null) ...[
                        InkWell(
                          onTap: () => launchExternalUrl(project.repoUrl!),
                          child: Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedGithub,
                                size: 14,
                                color: AppColors.success,
                                strokeWidth: 2,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'SOURCE',
                                style: textTheme.labelMedium?.copyWith(
                                  fontWeight: AppFonts.subheadingWeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                      if (project.demoUrl != null) ...[
                        InkWell(
                          onTap: () => context.go(
                            '/projects/${project.slug}?section=demo',
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_outward,
                                size: 14,
                                color: AppColors.success,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'LIVE',
                                style: textTheme.labelMedium?.copyWith(
                                  color: AppColors.success,
                                  fontWeight: AppFonts.subheadingWeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── SHARED WIDGETS ──────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String highlight;

  const _SectionHeader({
    required this.eyebrow,
    required this.title,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 20, height: 2, color: AppColors.success),
            const SizedBox(width: 8),
            Text(
              eyebrow,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.success,
                fontFamily: AppFonts.heading,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: textTheme.headlineMedium,
            children: [
              TextSpan(text: title),
              TextSpan(
                text: highlight,
                style: TextStyle(color: AppColors.success),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlowBentoCard extends StatefulWidget {
  final Widget child;
  const _GlowBentoCard({
    required this.child,
  });

  @override
  State<_GlowBentoCard> createState() => _GlowBentoCardState();
}

class _GlowBentoCardState extends State<_GlowBentoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glow = Tween<double>(
      begin: 0.15,
      end: 0.45,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.15)),
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
