class WorkExperience {
  final String company;
  final String period;
  final String role;
  final List<String> highlights;

  const WorkExperience({
    required this.company,
    required this.period,
    required this.role,
    required this.highlights,
  });
}

class SkillEntry {
  final String title;
  final String description;

  const SkillEntry({required this.title, required this.description});
}

const String aboutBio =
    'TODO: 2-3 paragraphs — who you are, what you build, what you care about as a developer.';

const List<WorkExperience> workExperience = [
  WorkExperience(
    company: 'Fiverr',
    period: '2024 - Present',
    role: 'Flutter Developer',
    highlights: [
      'TODO: what you actually did on this',
    ],
  ),
  WorkExperience(
    company: 'Upwork',
    period: '2024 - Present',
    role: 'UX/UI Designer',
    highlights: [
      'TODO: what you actually did on this',
    ],
  ),
];

const List<SkillEntry> technicalSkills = [
  SkillEntry(
    title: 'Mobile App Development',
    description:
        'Building cross-platform apps with Flutter and Dart, using Provider for state management and Firebase for backend services.',
  ),
  SkillEntry(
    title: 'UI/UX Design',
    description:
        'Figma-first design process — wireframing and prototyping before implementation, with a focus on reusable design systems.',
  ),
  SkillEntry(
    title: 'TODO: third skill area',
    description: 'TODO',
  ),
];