import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

class NavBar extends StatelessWidget {
  final String currentPath;
  final bool isCompact;

  const NavBar({super.key, required this.currentPath, required this.isCompact});

  static const double compactBreakpoint = 600;

  static const _items = [
    (icon: HugeIcons.strokeRoundedHome04, label: null, path: '/'),
    (
      icon: HugeIcons.strokeRoundedDashboardSquare01,
      label: 'Projects',
      path: '/projects',
    ),
    (icon: HugeIcons.strokeRoundedMail02, label: 'Contact', path: '/contact'),
    (icon: HugeIcons.strokeRoundedMoon02, label: null , path: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < compactBreakpoint;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _items.map((item) {
                      final isActive = currentPath == item.path;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: _NavPill(
                          icon: item.icon,
                          label: isCompact ? null : item.label,
                          isActive: isActive,
                          onTap: () => context.go(item.path),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavPill extends StatelessWidget {
  final dynamic icon;
  final String? label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavPill({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: icon,
              size: 18,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            if (label != null) ...[
              SizedBox(width: 6),
              Text(
                label!,
                style: TextStyle(
                  fontFamily: AppFonts.body,
                  fontSize: 12,
                  fontWeight: isActive
                      ? AppFonts.subheadingWeight
                      : AppFonts.headingWeight,
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
