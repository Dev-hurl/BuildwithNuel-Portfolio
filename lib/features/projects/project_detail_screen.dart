import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/core/widgets/live_app_embed.dart';
import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String slug;

  const ProjectDetailScreen({super.key, required this.slug});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final _demoSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final section = GoRouterState.of(context).uri.queryParameters['section'];
      if (section == 'demo' && _demoSectionKey.currentContext != null) {
        Scrollable.ensureVisible(
          _demoSectionKey.currentContext!,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final matches = projects.where((p) => p.slug == widget.slug);
    final project = matches.isEmpty ? null : matches.first;

    if (project == null) {
      return const Center(child: Text('Project not found'));
    }

    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.title, style: textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(project.tagline, style: textTheme.titleMedium),
          const SizedBox(height: 24),
          Text('Role: ${project.role}', style: textTheme.labelSmall),
          _buildImage(project),
          const SizedBox(height: 24),
          Text(project.description, style: textTheme.bodyMedium),
          const SizedBox(height: 24),
          Text('Tech stack: ${project.techStack.join(', ')}', style: textTheme.labelSmall),
          const SizedBox(height: 24),
          Text('Challenge', style: textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(project.challenge, style: textTheme.bodyMedium),
          const SizedBox(height: 16),
          Text('Solution', style: textTheme.titleLarge),
          const SizedBox(height: 24),
          Text(project.solution, style: textTheme.bodyMedium),

          // ── Demo section, new ──────────────────────────
          if (project.demoUrl != null) ...[
            const SizedBox(height: 32),
            Container(
              key: _demoSectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Live Demo', style: textTheme.titleLarge),
                  const SizedBox(height: 16),
                  DeviceFrameEmbed(appUrl: project.demoUrl!),
                ],
              ),
            ),
          ],
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
      borderRadius: BorderRadiusGeometry.circular(24),
      child: SizedBox(
        width: double.infinity,
        child: hasImage
            ? Image.asset(
                project.screenshotUrls.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.broken_image_outlined, size: 40, color: AppColors.textSecondary.withValues(alpha: 0.4)),
                ),
              )
            : Center(
                child: Icon(Icons.phone_iphone_outlined, size: 56, color: AppColors.textSecondary.withValues(alpha: 0.4)),
              ),
      ),
    ),
  );
}