import 'package:buildwithnuel/features/projects/models/project_data.dart';
import 'package:buildwithnuel/features/projects/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  // Placeholder only — not wired to actual filtering yet.
  static const _categories = [
    (label: 'Fintech', icon: Icons.account_balance_outlined),
    (label: 'SaaS', icon: Icons.cloud_outlined),
    (label: 'Productivity', icon: Icons.checklist_outlined),
    (label: 'E-commerce', icon: Icons.shopping_bag_outlined),
    (label: 'Taxi & Delivery', icon: Icons.local_taxi_outlined),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects', style: textTheme.headlineMedium),
          SizedBox(height: 16),
          Text(
            'A collection of Flutter apps across fintech, SaaS, and productivity.',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: List.generate(_categories.length, (index) {
              final category = _categories[index];
              final isSelected = index == _selectedIndex;
              return _CategoryPill(
                label: category.label,
                icon: category.icon,
                isSelected: isSelected,
                onTap: () => setState(() => _selectedIndex = index),
              );
            }),
          ),
          SizedBox(height: 40),
          ...projects.map(
            (project) => Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _ProjectFeatureCard(project: project),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryPill({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppFonts.body,
                fontSize: AppFonts.captionSize,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectFeatureCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectFeatureCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        //color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        //border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(project), // was _buildImagePlaceholder()
          Padding(
            padding: EdgeInsets.all(16),
            child: _buildInfo(context, textTheme),
          ),
        ],
      ),
    );
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

  Widget _buildInfo(BuildContext context, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.techStack
              .map((tech) => _TechBadge(label: tech))
              .toList(),
        ),
        SizedBox(height: 16),*/
        Text(project.title, style: textTheme.titleLarge),
        SizedBox(height: 8),
        Text(project.tagline, style: textTheme.labelSmall),
        SizedBox(height: 20),
        Row(
          children: [
            TextButton(
              onPressed: () => context.go('/projects/${project.slug}'),
              child: Text('View case study'),
            ),
            if (project.demoUrl != null) ...[
              SizedBox(width: 12),
              TextButton(
                onPressed: () {}, 
                child: Text('Live demo'),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TechBadge extends StatelessWidget {
  final String label;

  const _TechBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
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
