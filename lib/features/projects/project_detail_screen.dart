import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String slug;

  const ProjectDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final matches = projects.where((p) => p.slug == slug);
    final project = matches.isEmpty ? null : matches.first;

    if (project == null) {
      return const Center(child: Text('Project not found'));
    }

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading
          Text(project.title, style: textTheme.headlineMedium),
          SizedBox(height: 8),
          // subheading
          Text(project.tagline, style: textTheme.titleMedium),
          SizedBox(height: 24),
          // caption
          Text('Role: ${project.role}', style: textTheme.labelSmall),
          _buildImage(project),
            SizedBox(height: 24),
          SizedBox(height: 24),
          // body
          Text(project.description, style: textTheme.bodyMedium),
          SizedBox(height: 24),
          // caption
          Text(
            'Tech stack: ${project.techStack.join(', ')}',
            style: textTheme.labelSmall,
          ),
          SizedBox(height: 24),
          // title
          Text('Challenge', style: textTheme.titleLarge),
          SizedBox(height: 16),
          Text(project.challenge, style: textTheme.bodyMedium),
          SizedBox(height: 16),
          // title
          Text('Solution', style: textTheme.titleLarge),
          SizedBox(height: 24),
          Text(project.solution, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

Widget _buildImage(ProjectModel project) {
    final hasImage = project.screenshotUrls.isNotEmpty;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius:  BorderRadiusGeometry.circular(24),
        child: SizedBox(
          width: double.infinity,
          //color: AppColors.surfaceVariant,
          child: hasImage
              ? Image.asset(
                  project.screenshotUrls.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 40,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                  ),
                )
              : Center(
                  child: Icon(
                    Icons.phone_iphone_outlined,
                    size: 56,
                    color: AppColors.textSecondary.withValues(alpha: 0.4),
                  ),
                ),
        ),
      ),
    );
  }