import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/launch_url.dart';

class ProjectListCard extends StatefulWidget {
  final ProjectModel project;
  const ProjectListCard({super.key, required this.project});

  @override
  State<ProjectListCard> createState() => _ProjectListCardState();
}

class _ProjectListCardState extends State<ProjectListCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final textTheme = Theme.of(context).textTheme;
    final hasImage = project.screenshotUrls.isNotEmpty;

    return InkWell(
      onTap: () {
        context.go('/projects/${project.slug}');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: hasImage
                        ? Image.asset(
                            project.screenshotUrls.first,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: AppColors.surfaceVariant,
                                  child: Icon(
                                    Icons.apps,
                                    size: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                          )
                        : Container(
                            color: AppColors.surfaceVariant,
                            child: Icon(
                              Icons.apps,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: TextStyle(
                          fontFamily: AppFonts.body,
                          fontSize: AppFonts.captionSize,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(project.year, style: textTheme.labelMedium),
                    ],
                  ),
                ),
                if (project.demoUrl != null)
                  IconButton(
                    onPressed: () => launchExternalUrl(project.demoUrl!),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedLinkSquare01,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    tooltip: 'Open live project',
                  ),
                IconButton(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  icon: HugeIcon(
                    icon: _expanded
                        ? HugeIcons.strokeRoundedChevronsDownUp
                        : HugeIcons.strokeRoundedArrowUpDouble,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  tooltip: _expanded ? 'Collapse' : 'Expand',
                ),
              ],
            ),
            if (_expanded) ...[
              SizedBox(height: 12),
              Text(project.description, style: textTheme.bodyMedium),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.techStack
                    .map((tech) => _TechTag(label: tech))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: AppFonts.body,
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
