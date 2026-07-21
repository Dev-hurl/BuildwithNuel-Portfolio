import 'package:buildwithnuel/core/widgets/live_app_embed.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';
import '../utils/launch_url.dart';

class LiveDemoModal extends StatelessWidget {
  final String appUrl;
  final String title;
  const LiveDemoModal({super.key, required this.appUrl, required this.title});

  static void show(
    BuildContext context, {
    required String appUrl,
    required String title,
  }) {
    showDialog(
      context: context,
      barrierColor: AppColors.background.withValues(alpha: 0.9),
      builder: (_) => LiveDemoModal(appUrl: appUrl, title: title),
    );
  }

  static const double _wideBreakpoint = 800;
  static const double _maxModalWidth = 1400;
  static const double _margin = 48;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > _wideBreakpoint;

    final modalWidth = isWide
        ? (screenWidth - _margin * 2).clamp(0, _maxModalWidth).toDouble()
        : screenWidth;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: isWide
          ? EdgeInsets.symmetric(
              horizontal: (screenWidth - modalWidth) / 2,
              vertical: _margin,
            )
          : EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: LiveAppEmbed(appUrl: appUrl)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppFonts.heading,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Live Preview',
                  style: TextStyle(
                    fontFamily: AppFonts.body,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => launchExternalUrl(appUrl),
            icon: Icon(Icons.open_in_new, size: 16),
            label: Text('Open in New Tab'),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
