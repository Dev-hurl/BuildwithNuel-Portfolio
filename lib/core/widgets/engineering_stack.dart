// engineering_stack_section.dart
import 'package:buildwithnuel/core/models/skill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EngineeringStackSection extends StatefulWidget {
  const EngineeringStackSection({super.key});

  @override
  State<EngineeringStackSection> createState() =>
      _EngineeringStackSectionState();
}

class _EngineeringStackSectionState extends State<EngineeringStackSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScroll());
  }

  void _startScroll() async {
    while (mounted) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 20),
        curve: Curves.linear,
      );
      _scrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0D0D0D),
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section label
          Row(
            children: [
              Container(width: 24, height: 2, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'ENGINEERING STACK',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // heading
          Text(
            'Built with the',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'right tools',
            style: TextStyle(
              color: Colors.green,
              fontSize: 48,
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 16),

          Text(
            'Mobile apps, beautiful UIs, and scalable backends.',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),

          const SizedBox(height: 48),

          // divider + label
          Row(
            children: [
              const Text(
                'LANGUAGES & FRAMEWORKS',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: Divider(color: Colors.white12)),
            ],
          ),

          const SizedBox(height: 24),

          // scrolling skills row
          SizedBox(
            height: 48,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length * 3, // repeat for seamless loop
              separatorBuilder: (_, _) => const SizedBox(width: 32),
              itemBuilder: (context, index) {
                final skill = skills[index % skills.length];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      skill.iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.white70,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      skill.name,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}