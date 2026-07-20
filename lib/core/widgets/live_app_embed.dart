import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

enum DeviceFrame { iphone, android, tablet }

class FrameSpec {
  final double aspectRatio;
  final double bezelWidth;
  final double cornerRadius;
  final Widget? notch;

  const FrameSpec({
    required this.aspectRatio,
    required this.bezelWidth,
    required this.cornerRadius,
    this.notch,
  });
}

final Map<DeviceFrame, FrameSpec> frameSpecs = {
  DeviceFrame.iphone: FrameSpec(
    aspectRatio: 9 / 19.5,
    bezelWidth: 10,
    cornerRadius: 44,
    notch: Container(
      width: 90, height: 22,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14)),
    ),
  ),
  DeviceFrame.android: FrameSpec(
    aspectRatio: 9 / 19,
    bezelWidth: 6,
    cornerRadius: 28,
    notch: Container(
      width: 12, height: 12,
      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    ),
  ),
  DeviceFrame.tablet: FrameSpec(aspectRatio: 3 / 4, bezelWidth: 14, cornerRadius: 20, notch: null),
};

class LiveAppEmbed extends StatefulWidget {
  final String appUrl;
  const LiveAppEmbed({super.key, required this.appUrl});

  @override
  State<LiveAppEmbed> createState() => _LiveAppEmbedState();
}

class _LiveAppEmbedState extends State<LiveAppEmbed> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'orbitask-iframe-${widget.appUrl.hashCode}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..src = widget.appUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewType);
}

class DeviceFrameEmbed extends StatefulWidget {
  final String appUrl;
  const DeviceFrameEmbed({super.key, required this.appUrl});

  @override
  State<DeviceFrameEmbed> createState() => _DeviceFrameEmbedState();
}

class _DeviceFrameEmbedState extends State<DeviceFrameEmbed> {
  DeviceFrame _selected = DeviceFrame.iphone;

  @override
  Widget build(BuildContext context) {
    final spec = frameSpecs[_selected]!;

    return Column(
      children: [
        Wrap(
          spacing: 8,
          children: DeviceFrame.values.map((f) => ChoiceChip(
            label: Text(f.name),
            selected: f == _selected,
            onSelected: (_) => setState(() => _selected = f),
          )).toList(),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 320,
          child: AspectRatio(
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
                  if (spec.notch != null)
                    Positioned(top: 8, left: 0, right: 0, child: Center(child: spec.notch)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}