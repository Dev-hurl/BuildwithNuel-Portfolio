import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > _wideBreakpoint;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHero(context, textTheme),
                  const SizedBox(height: 80),
                  _buildFeaturedProjects(context, textTheme, isWide),
                  const SizedBox(height: 80),
                  _buildSkillsStrip(textTheme),
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 8, color: AppColors.accent),
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
                padding: EdgeInsets.symmetric(
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
                padding: EdgeInsets.symmetric(
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

  Widget _buildFeaturedProjects(
    BuildContext context,
    TextTheme textTheme,
    bool isWide,
  ) {
    final featured = projects.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured Projects', style: textTheme.titleLarge),
            TextButton(
              onPressed: () => context.go('/projects'),
              child: Text('View all →'),
            ),
          ],
        ),
        SizedBox(height: 20),
        isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: featured
                    .map(
                      (p) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: _FeaturedCard(project: p),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Column(
                children: featured
                    .map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _FeaturedCard(project: p),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildSkillsStrip(TextTheme textTheme) {
    const skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'Provider',
      'go_router',
      'Figma',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tech Stack', style: textTheme.titleLarge),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontFamily: AppFonts.body,
                      fontSize: AppFonts.captionSize,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final ProjectModel project;
  const _FeaturedCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasImage = project.screenshotUrls.isNotEmpty;

    return InkWell(
      onTap: () => context.go('/projects/${project.slug}'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
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
                child: hasImage
                    ? Image.asset(
                        project.screenshotUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 32,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.phone_iphone_outlined,
                          size: 40,
                          color: AppColors.textSecondary.withValues(alpha: 0.4),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title, style: textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    project.tagline,
                    style: textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
