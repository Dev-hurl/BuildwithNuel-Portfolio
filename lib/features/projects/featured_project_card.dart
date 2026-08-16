import 'dart:ui';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/launch_url.dart';

class FeaturedProjectCard extends StatelessWidget {
  final ProjectModel project;
  const FeaturedProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasImage = project.screenshotUrls.isNotEmpty;
    final hasIcon = project.appIcon.isNotEmpty;

    return InkWell(
      onTap: () => context.go('/projects/${project.slug}'),
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Layer 1 — image fills the whole card
              hasImage
                  ? Image.asset(
                      project.screenshotUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.surfaceVariant),
                    )
                  : Container(color: AppColors.surfaceVariant),

              // Layer 2
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    enabled: true,
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      color: AppColors.background.withValues(alpha: 0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: hasIcon
                                      ? Image.asset(
                                          project.appIcon,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color: AppColors.surfaceVariant,
                                          child: Icon(Icons.apps),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  project.title,
                                  style: textTheme.headlineMedium?.copyWith(
                                    fontSize: AppFonts.titleSize,
                                  ),
                                ),
                              ),
                              if (project.demoUrl != null)
                                IconButton(
                                  onPressed: () =>
                                      launchExternalUrl(project.demoUrl!),
                                  icon: Icon(
                                    Icons.open_in_new,
                                    size: 16,
                                    color: AppColors.white,
                                  ),
                                  tooltip: 'Open live demo',
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            project.tagline,
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
