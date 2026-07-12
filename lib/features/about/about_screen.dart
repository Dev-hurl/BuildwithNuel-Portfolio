import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import 'about_data.dart';

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
    throw Exception('Could not launch $url');
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const double _wideBreakpoint = 800;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > _wideBreakpoint;
        return isWide
            ? _WideLayout(textTheme: textTheme)
            : _NarrowLayout(textTheme: textTheme);
      },
    );
  }
}

class _WideLayout extends StatelessWidget {
  final TextTheme textTheme;

  const _WideLayout({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 240, child: _AvatarBlock()), // pinned, not scrollable
          SizedBox(width: 48),
          Expanded(
            child: SingleChildScrollView(
              child: _AboutContent(textTheme: textTheme),
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final TextTheme textTheme;

  const _NarrowLayout({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _AvatarBlock()),
          SizedBox(height: 32),
          _AboutContent(textTheme: textTheme),
        ],
      ),
    );
  }
}

class _AvatarBlock extends StatelessWidget {
  const _AvatarBlock();

  static const _avatarPath = 'assets/images/avatar.jpg';
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 56,
      backgroundColor: AppColors.surfaceVariant,
      child: ClipOval(
        child: Image.asset(
          _avatarPath,
          width: 112,
          height: 112,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => HugeIcon(
            icon: HugeIcons.strokeRoundedUserCircle,
            size: 48,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final TextTheme textTheme;

  const _AboutContent({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Emmanuel Oluwaseyi Adekanmbi ', style: textTheme.headlineMedium),
        SizedBox(height: 4),
        Text('Flutter Developer', style: textTheme.titleMedium),
        SizedBox(height: 16),
        Row(
          spacing: 12,
          children: [
            _SocialIcon(
              icon: HugeIcons.strokeRoundedGithub01,
              onTap: () => _launchUrl('https://github.com/Dev-hurl'),
            ),
            _SocialIcon(
              icon: HugeIcons.strokeRoundedLinkedin01,
              onTap: () =>
                  _launchUrl('https://www.linkedin.com/in/buildwithnuel'),
            ),
            _SocialIcon(
              icon: HugeIcons.strokeRoundedNewTwitterRectangle,
              onTap: () => _launchUrl('https://x.com/BuildwithNuel'),
            ),
            _SocialIcon(
              icon: HugeIcons.strokeRoundedMail01,
              onTap: () => _launchUrl('mailto:devhurl7@gmail.com'),
            ),
          ],
        ),
        SizedBox(height: 32),
        Text(aboutBio, style: textTheme.bodyMedium),
        SizedBox(height: 48),
        Text('Work Experience', style: textTheme.headlineMedium),
        SizedBox(height: 24),
        ...workExperience.map(
          (exp) => Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: _ExperienceItem(experience: exp, textTheme: textTheme),
          ),
        ),
        SizedBox(height: 24),
        Text('Technical Skills', style: textTheme.headlineMedium),
        SizedBox(height: 24),
        ...technicalSkills.map(
          (skill) => Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _SkillItem(skill: skill, textTheme: textTheme),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: HugeIcon(icon: icon, size: 18, color: AppColors.white),
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final WorkExperience experience;
  final TextTheme textTheme;

  const _ExperienceItem({required this.experience, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(experience.company, style: textTheme.titleLarge),
            Text(experience.period, style: textTheme.labelSmall),
          ],
        ),
        const SizedBox(height: 4),
        Text(experience.role, style: textTheme.titleMedium),
        const SizedBox(height: 12),
        ...experience.highlights.map(
          (point) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•  ', style: textTheme.bodyMedium),
                Expanded(child: Text(point, style: textTheme.bodyMedium)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillItem extends StatelessWidget {
  final SkillEntry skill;
  final TextTheme textTheme;

  const _SkillItem({required this.skill, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(skill.title, style: textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(skill.description, style: textTheme.bodyMedium),
      ],
    );
  }
}
