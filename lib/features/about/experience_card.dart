import 'package:buildwithnuel/features/about/about_data.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';

class ExperienceCard extends StatefulWidget {
  final WorkExperience experience;
  const ExperienceCard({super.key, required this.experience});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBox(icon: HugeIcons.strokeRoundedWork),
              SizedBox(width: 10),
              Text(
                exp.company,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (exp.isCurrent) ...[
                SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _IconBox(icon: HugeIcons.strokeRounded3rdBracket),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        exp.role,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      icon: HugeIcon(
                        icon: _expanded
                            ? HugeIcons.strokeRoundedUnfoldLess
                            : HugeIcons.strokeRoundedUnfoldMore,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '${exp.type}  |  ${exp.period}  |  ${exp.location}',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: AppFonts.subheadingWeight
                  ),
                ),
                if (_expanded) ...[
                  SizedBox(height: 10),
                  Text(exp.description, style: textTheme.labelMedium,),
                ],
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: exp.techStack
                      .map((tech) => _TechTag(label: tech))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final dynamic icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: UnconstrainedBox(
        child: HugeIcon(icon: icon, size: 18, color: AppColors.textSecondary),
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
        color: AppColors.surface,
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
