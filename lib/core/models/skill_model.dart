class SkillModel {
  final String name;
  final String iconPath; 
  const SkillModel({
    required this.name,
    required this.iconPath,
  });
}

final List<SkillModel> skills = [
  SkillModel(name: 'FLUTTER', iconPath: 'assets/icons/skills/flutter.svg'),
  SkillModel(name: 'DART', iconPath: 'assets/icons/skills/dart.svg'),
  SkillModel(name: 'FIREBASE', iconPath: 'assets/icons/skills/firebase.svg'),
  SkillModel(name: 'FIGMA', iconPath: 'assets/icons/skills/figma.svg'),
  SkillModel(name: 'CLAUDE', iconPath: 'assets/icons/skills/claude.svg'),
  // add more here
];