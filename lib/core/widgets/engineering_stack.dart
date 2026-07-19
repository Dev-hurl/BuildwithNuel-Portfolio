// engineering_stack_section.dart
import 'package:buildwithnuel/core/constants/app_colors.dart';
import 'package:buildwithnuel/core/constants/app_fonts.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
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
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.success,
                  fontFamily: AppFonts.heading,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // heading
          Text.rich(
            TextSpan(
              style: textTheme.headlineMedium,
              children: [
                TextSpan(text: 'Built with the'),
                TextSpan(
                  text: '\nright tools',
                  style: TextStyle(color: AppColors.success),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          Text(
            'Mobile apps, beautiful UIs, and scalable backends.',
            style: textTheme.labelMedium,
          ),

          SizedBox(height: 48),

          // divider + label
          Row(
            children: [
              Text(
                'LANGUAGES & FRAMEWORKS',
                style: textTheme.labelMedium
                  ?..copyWith(fontFamily: AppFonts.heading),
              ),
              SizedBox(width: 16),
              Expanded(child: Divider(color: AppColors.textSecondary)),
            ],
          ),

          SizedBox(height: 24),

          // scrolling skills row
          SizedBox(
            height: 48,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: skills.length * 3, // repeat for seamless loop
              separatorBuilder: (_, _) => const SizedBox(width: 32),
              itemBuilder: (context, index) {
                final skill = skills[index % skills.length];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      skill.iconPath,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.success.withValues(alpha: 0.65),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      skill.name,
                      style: textTheme.labelMedium,
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
