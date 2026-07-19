import 'package:buildwithnuel/core/widgets/engineering_stack.dart';
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

  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isWide = width > _wideBreakpoint;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHero(context, textTheme),
                  SizedBox(height: 80),
                  EngineeringStackSection(),
                  SizedBox(height: 80),
                  _buildWhoIAmCard(context, textTheme),
                  SizedBox(height: 80),
                  _buildWorkExperienceSection(context, textTheme, width),
                  SizedBox(height: 80),
                  _buildProjectsSection(context, textTheme, width),
                  SizedBox(height: 80),
                  //_buildSkillsStrip(textTheme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHero(BuildContext context, TextTheme textTheme) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 8, color: AppColors.success),
              SizedBox(width: 8),
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
        SizedBox(height: 24),
        Text.rich(
          TextSpan(
            style: textTheme.headlineMedium,
            children: [
              TextSpan(text: 'Building Flutter apps '),
              TextSpan(
                text: 'that feel right.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480),
          child: Text(
            'Flutter developer & UX/UI designer building apps across fintech, SaaS, and productivity.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
        ),
        SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.go('/projects'),
              icon: Icon(Icons.arrow_forward, size: 18),
              label: Text('View Projects'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/contact'),
              icon: Icon(Icons.mail_outline, size: 18),
              label: Text('Get in Touch'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(color: AppColors.border),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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

  Widget _buildWorkExperienceSection(
    BuildContext context,
    TextTheme textTheme,
    double width,
  ) {
    final columns = width < 500 ? 1 : (width < 900 ? 2 : 3);
    const spacing = 16.0;
    final cardWidth =
        (width - spacing * (columns - 1) - 48) /
        columns; // -48 accounts for new container padding

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          eyebrow: 'EXPERIENCE',
          title: "Where I've ",
          highlight: 'shipped',
        ),
        const SizedBox(height: 24),
        _BracketSection(
          // new wrapper
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: workExperience
                .map(
                  (exp) => SizedBox(
                    width: cardWidth,
                    child: _WorkExperienceCard(experience: exp),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsSection(
    BuildContext context,
    TextTheme textTheme,
    double width,
  ) {
    final columns =
        width <
            500 //TODO: Adjust breakpoint to fit if the screen sizes becomes smaller or bigger
        ? 1
        : (width < 800 ? 2 : (width < 1100 ? 3 : 4));
    const spacing = 16.0;
    final cardWidth = (width - spacing * (columns - 1)) / columns;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          eyebrow: 'PROJECTS',
          title: "Things I've ",
          highlight: 'built',
        ),
        SizedBox(height: 24),
        Wrap(
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
        ),
      ],
    );
  }
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
        SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: textTheme.headlineMedium,
            children: [
              TextSpan(text: 'Full Stack\n'),
              TextSpan(
                text: 'Engineer\n',
                style: TextStyle(color: AppColors.success),
              ),
              TextSpan(text: 'Motion UI\n'),
              TextSpan(text: 'Premium\n'),
              TextSpan(
                text: 'Design',
                style: TextStyle(color: AppColors.success),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Turning code into experiences you feel, remember, and can't stop coming back to.",
          style: textTheme.bodyMedium,
        ),
        
      ],
    ),
  );
}

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
            SizedBox(width: 8),
            Text(
              eyebrow,
              style: TextStyle(
                fontFamily: AppFonts.body,
                fontSize: AppFonts.smallSize,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
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
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(experience.company, style: textTheme.labelLarge),
                  Text(experience.role, style: textTheme.labelMedium),
                  SizedBox(height: 8),
                  Text(experience.period, style: textTheme.labelSmall),
                ],
              ),
            ],
          ),
          Divider(color: AppColors.border, height: 8),
          SizedBox(height: 16),
          ...experience.highlights.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.circle,
                      size: 2.5,
                      color: AppColors.success,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(children: [Text(point, style: textTheme.labelSmall)]),
                ],
              ),
            ),
          ),
        ],
      ),
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
          color: AppColors.surface,
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
                color: AppColors.surfaceVariant,
                child: Center(
                  child: Icon(
                    Icons.crop_square_outlined,
                    size: 28,
                    color: AppColors.success.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.techStack.isNotEmpty
                        ? project.techStack.join(' · ').toUpperCase()
                        : 'PROJECT',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(project.title, style: textTheme.titleMedium),
                  SizedBox(height: 8),
                  Text(
                    project.tagline,
                    style: textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      if (project.repoUrl != null) ...[
                        Icon(
                          Icons.code,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text('Source', style: textTheme.labelLarge),
                        SizedBox(width: 16),
                      ],
                      if (project.demoUrl != null) ...[
                        Icon(
                          Icons.arrow_outward,
                          size: 14,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Live',
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.success,
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

class _GlowBentoCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _GlowBentoCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
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
        padding: widget.padding,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.15)),
        ),
        child: Stack(clipBehavior: Clip.none, children: [child!]),
      ),
      child: widget.child,
    );
  }
}

class _BracketSection extends StatelessWidget {
  final Widget child;
  const _BracketSection({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: child,
        ),
        ..._corners(),
      ],
    );
  }

  List<Widget> _corners() {
    const len = 16.0, thick = 1.0;
    Widget corner(bool top, bool left) => Positioned(
      top: top ? -1 : null,
      bottom: !top ? -1 : null,
      left: left ? -1 : null,
      right: !left ? -1 : null,
      child: SizedBox(
        width: len,
        height: len,
        child: Stack(
          children: [
            Positioned(
              top: top ? 0 : null,
              bottom: !top ? 0 : null,
              left: 0,
              right: 0,
              child: Container(height: thick, color: AppColors.success),
            ),
            Positioned(
              left: left ? 0 : null,
              right: !left ? 0 : null,
              top: 0,
              bottom: 0,
              child: Container(width: thick, color: AppColors.success),
            ),
          ],
        ),
      ),
    );
    return [
      corner(true, true),
      corner(true, false),
      corner(false, true),
      corner(false, false),
    ];
  }
}
