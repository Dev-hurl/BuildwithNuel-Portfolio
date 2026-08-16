class WorkExperience {
  final String company;
  final bool isCurrent;
  final String type; // e.g. 'Internship', 'Full-time'
  final String role;
  final String period; // e.g. 'May 2025 – July 2025'
  final String location;
  final String description;
  final List<String> techStack;

  const WorkExperience({
    required this.company,
    this.isCurrent = false,
    required this.type,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
    required this.techStack,
  });
}

const workExperiences = [
  WorkExperience(
    company: 'Freelance',
    role: 'UX/UI Designer',
    isCurrent: true,
    type: 'Freelance',
    period: 'January 2024 – Present',
    location: 'Remote',
    description:
        'Building mobile and web applications for clients across various industries, focusing on Flutter development and user experience design.',
    techStack: [
      'Figma',
      'Google Stitch',
    ],
  ),
  WorkExperience(
    company: 'Freelance',
    role: 'Flutter Developer',
    isCurrent: true,
    type: 'Freelance',
    period: 'June 2025 – Present',
    location: 'Remote',
    description:
        'Building mobile and web applications for clients across various industries, focusing on Flutter development and user experience design.',
    techStack: [
      'Flutter',
      'Dart',
      'Firebase',
      'Supabase',
      'Provider',
      'Firestore',
      '',
    ],
  ),
];
