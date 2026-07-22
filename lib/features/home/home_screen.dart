import 'package:buildwithnuel/core/widgets/engineering_stack.dart';
import 'package:buildwithnuel/core/widgets/projects_list_card.dart';
import 'package:buildwithnuel/features/about/about_data.dart';
import 'package:buildwithnuel/features/about/experience_card.dart';
import 'package:buildwithnuel/features/about/profile_card.dart';
import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;

    final isWide = width > 800;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 160 : 52, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //_buildHero(context, textTheme),
              SizedBox(height: 80),
              ProfileCard(),
              SizedBox(height: 60),
              EngineeringStackSection(),
              SizedBox(height: 60),
              _WorkExperienceSection(),
              SizedBox(height: 60),
              _ProjectsSection(),
              SizedBox(height: 60),
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
              icon: Icon(Icons.mail_outline, size: 18),
              label: Text('Get in Touch'),
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
}

// ── EXPERIENCE SECTION ──────────────────────────────────────

class _WorkExperienceSection extends StatelessWidget {
  const _WorkExperienceSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 20, color: AppColors.success),
            SizedBox(width: 10),
            Text(
              'Experience',
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontFamily: AppFonts.heading,
                fontWeight: AppFonts.titleWeight,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColors.border),
        SizedBox(height: 16),
        ...workExperiences.map(
          (exp) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: ExperienceCard(experience: exp),
          ),
        ),
      ],
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
            SizedBox(height: 24),
            if (isWide) _buildGrid(constraints.maxWidth) else _buildStack(),
          ],
        );
      },
    );
  }

  Widget _buildGrid(double maxWidth) {
    return Column(
      children: projects
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProjectListCard(project: p),
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
              padding: EdgeInsets.only(bottom: 8),
              child: ProjectListCard(project: p),
            ),
          )
          .toList(),
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
            Container(width: 4, height: 20, color: AppColors.success),
            SizedBox(width: 10),
            Text(
              eyebrow,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontFamily: AppFonts.heading,
                fontWeight: AppFonts.titleWeight,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColors.border),
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
