import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

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
    _viewType = 'live-embed-${widget.appUrl.hashCode}';
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