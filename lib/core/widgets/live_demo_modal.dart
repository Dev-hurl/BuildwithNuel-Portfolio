import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';
import '../utils/launch_url.dart';
import 'live_app_embed.dart'; // has DeviceFrame enum, _frameSpecs, LiveAppEmbed

class LiveDemoModal extends StatefulWidget {
  final String appUrl;
  final String title;
  const LiveDemoModal({super.key, required this.appUrl, required this.title});

  static void show(BuildContext context, {required String appUrl, required String title}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (_) => LiveDemoModal(appUrl: appUrl, title: title),
    );
  }

  @override
  State<LiveDemoModal> createState() => _LiveDemoModalState();
}

class _LiveDemoModalState extends State<LiveDemoModal> {
  DeviceFrame _selectedDevice = DeviceFrame.iphone;
  Color _backgroundColor = AppColors.background;
  bool _settingsExpanded = false;

  static final List<Color> _backgroundOptions = [
    AppColors.background,
    Colors.white,
    AppColors.surfaceVariant,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        color: AppColors.surface,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Container(
                color: _backgroundColor,
                child: Center(
                  child: SizedBox(width: 320, child: _buildFrame()),
                ),
              ),
            ),
            _buildSettingsPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: TextStyle(fontFamily: AppFonts.heading, fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text('Live Preview', style: TextStyle(fontFamily: AppFonts.body, fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => launchExternalUrl(widget.appUrl),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Open in New Tab'),
          ),
          IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
        ],
      ),
    );
  }

  Widget _buildFrame() {
    final spec = frameSpecs[_selectedDevice]!;
    return AspectRatio(
      aspectRatio: spec.aspectRatio,
      child: Container(
        padding: EdgeInsets.all(spec.bezelWidth),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(spec.cornerRadius)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(spec.cornerRadius - spec.bezelWidth),
              child: LiveAppEmbed(appUrl: widget.appUrl),
            ),
            if (spec.notch != null) Positioned(top: 8, left: 0, right: 0, child: Center(child: spec.notch)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => setState(() => _settingsExpanded = !_settingsExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                Icon(Icons.tune, size: 18, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text('Device Preview', style: TextStyle(color: AppColors.textPrimary)),
                const Spacer(),
                Icon(_settingsExpanded ? Icons.expand_less : Icons.expand_more, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        if (_settingsExpanded)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DEVICE', style: TextStyle(fontSize: 11, letterSpacing: 0.5, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: DeviceFrame.values
                      .map((d) => ChoiceChip(
                            label: Text(d.name),
                            selected: d == _selectedDevice,
                            onSelected: (_) => setState(() => _selectedDevice = d),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text('BACKGROUND COLOR', style: TextStyle(fontSize: 11, letterSpacing: 0.5, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: _backgroundOptions
                      .map((c) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setState(() => _backgroundColor = c),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _backgroundColor == c ? AppColors.success : AppColors.border,
                                    width: _backgroundColor == c ? 2 : 1,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}