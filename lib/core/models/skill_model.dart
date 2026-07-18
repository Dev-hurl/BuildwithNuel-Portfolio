class SkillModel {
  final String name;
  final String iconPath; // svg path

  const SkillModel({
    required this.name,
    required this.iconPath,
  });
}

final List<SkillModel> skills = [
  SkillModel(name: 'Flutter', iconPath: 'assets/icons/skills/flutter.svg'),
  SkillModel(name: 'Dart', iconPath: 'assets/icons/skills/dart.svg'),
  SkillModel(name: 'Firebase', iconPath: 'assets/icons/skills/firebase.svg'),
  SkillModel(name: 'Figma', iconPath: 'assets/icons/skills/figma.svg'),
  SkillModel(name: 'Claude', iconPath: 'assets/icons/skills/claude.svg'),
  // add more here
];