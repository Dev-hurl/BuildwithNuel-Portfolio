import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/launch_url.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AvatarBlock(),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Adekanmbi Emmanuel',
                            style: textTheme.bodyMedium,
                          ),
                        ),

                        SizedBox(width: 6),
                        Icon(
                          Icons.verified,
                          size: 16,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 10),
                        // _StatusPill(label: 'Building side projects'),
                      ],
                    ),
                    SizedBox(height: 4),
                    Divider(color: AppColors.border, height: 1),
                    SizedBox(height: 4),
                    Text(
                      'Flutter Developer & UX/UI Designer',
                      style: textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(color: AppColors.border, height: 1),
          SizedBox(height: 20),
          Wrap(
            spacing: 32,
            runSpacing: 12,
            children: [
              _InfoRow(
                icon: HugeIcons.strokeRoundedWork,
                text: 'Mobile Developer',
              ),
              _InfoRow(
                icon: HugeIcons.strokeRoundedLocation10,
                text: 'Nigeria',
              ),
              _InfoRow(
                icon: HugeIcons.strokeRoundedMail01,
                text: 'devhurl@email.com',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _SocialLink(
                icon: HugeIcons.strokeRoundedGithub,
                label: 'GitHub',
                onTap: () => launchExternalUrl('https://github.com/Dev-hurl'),
              ),
              SizedBox(width: 24),
              _SocialLink(
                icon: HugeIcons.strokeRoundedNewTwitter,
                label: 'X',
                onTap: () => launchExternalUrl('https://x.com/BuildwithNuel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarBlock extends StatelessWidget {
  const _AvatarBlock();
  static const String _avatarPath = 'assets/images/avatar.jpg';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: AppColors.surfaceVariant,
      child: ClipOval(
        child: Image.asset(
          _avatarPath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => HugeIcon(
            icon: HugeIcons.strokeRoundedUser,
            size: 36,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  const _StatusPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: AppColors.success),
          SizedBox(width: 6),
          Text(
            label,
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

class _InfoRow extends StatelessWidget {
  final dynamic icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: UnconstrainedBox(
              child: HugeIcon(
                icon: icon,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.body,
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;
  const _SocialLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: HugeIcon(
              icon: icon,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.body,
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
