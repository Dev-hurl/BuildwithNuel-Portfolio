import 'package:buildwithnuel/core/widgets/engineering_stack.dart';
import 'package:buildwithnuel/core/widgets/projects_list_card.dart';
import 'package:buildwithnuel/features/about/about_data.dart';
import 'package:buildwithnuel/features/about/experience_card.dart';
import 'package:buildwithnuel/features/about/profile_card.dart';
import 'package:buildwithnuel/features/projects/featured_project_card.dart';
import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isWide = width > 800;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 120 : 40,
        vertical: 48,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 80),
            ProfileCard(),
            SizedBox(height: 60),
            EngineeringStackSection(),
            SizedBox(height: 60),
            _FeaturedProjectsSection(),
            _WorkExperienceSection(),
            SizedBox(height: 60),
            _ProjectsSection(),
            SizedBox(height: 60),
          ],
        ),
      ),
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

class _FeaturedProjectsSection extends StatelessWidget {
  const _FeaturedProjectsSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final featured = projects.take(2).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Featured Projects', style: textTheme.titleLarge),
                TextButton.icon(
                  onPressed: () => context.go('/projects'),
                  icon: const Icon(Icons.arrow_outward, size: 14),
                  label: const Text('View All Work'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: featured
                    .map(
                      (p) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FeaturedProjectCard(project: p),
                        ),
                      ),
                    )
                    .toList(),
              )
            else
              Column(
                children: featured
                    .map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FeaturedProjectCard(project: p),
                      ),
                    )
                    .toList(),
              ),
          ],
        );
      },
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
