// skills_section.dart
import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillItem {
  final String label;
  final String iconPath;

  const SkillItem({required this.label, required this.iconPath});
}

// Languages & Frameworks list
const List<SkillItem> langAndFrameworks = [
  SkillItem(label: 'Dart', iconPath: 'assets/icons/skills/dart.svg'),
  SkillItem(label: 'Flutter', iconPath: 'assets/icons/skills/flutter.svg'),
];

// Tools list
const List<SkillItem> tools = [
  SkillItem(label: 'Firebase', iconPath: 'assets/icons/skills/firebase.svg'),
  SkillItem(label: 'Firestore', iconPath: 'assets/icons/skills/firestore.svg'),
  SkillItem(label: 'Supabase', iconPath: 'assets/icons/skills/supabase.svg'),
  SkillItem(label: 'VS Code', iconPath: 'assets/icons/skills/vscode.svg'),
  SkillItem(label: 'GitHub', iconPath: 'assets/icons/skills/github.svg'),
  SkillItem(label: 'Vercel', iconPath: 'assets/icons/skills/vercel-light.svg'),
  SkillItem(
    label: 'Claude Code',
    iconPath: 'assets/icons/skills/claude-code.svg',
  ),
  SkillItem(label: 'Figma', iconPath: 'assets/icons/skills/figma.svg'),
  SkillItem(label: 'Framer', iconPath: 'assets/icons/skills/framer-logo.svg'),
];

class SkillChip extends StatelessWidget {
  final SkillItem item;

  const SkillChip({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(item.iconPath, width: 16, height: 16),
          const SizedBox(width: 8),
          Text(
            item.label,
            style: TextStyle(
              fontFamily: AppFonts.body,
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            _SkillBox(
              title: 'Languages & Frameworks',
              items: langAndFrameworks,
            ),
            const SizedBox(height: 16),
            _SkillBox(title: 'Tools', items: tools),
          ],
        );
      },
    );
  }
}

class _SkillBox extends StatelessWidget {
  final String title;
  final List<SkillItem> items;

  const _SkillBox({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) => SkillChip(item: item)).toList(),
          ),
        ],
      ),
    );
  }
}
