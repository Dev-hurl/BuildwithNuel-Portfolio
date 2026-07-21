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
    company: 'Fiverr',
    role: 'Flutter Developer & UX/UI Designer',
    isCurrent: true,
    type: 'Freelance',
    period: 'January 2022 – Present',
    location: 'Remote',
    description:
        'Building mobile and web applications for clients across various industries, focusing on Flutter development and user experience design.',
    techStack: ['Flutter', 'Dart', 'Firebase', 'Supabase', 'Figma'],
  ),
  WorkExperience(
    company: 'Tech Solutions Inc.',
    role: 'Software Engineer',
    isCurrent: false,
    type: 'Full-time',
    period: 'June 2020 – December 2021',
    location: 'New York, NY',
    description:
        'Developed and maintained web applications, collaborated with cross-functional teams, and implemented new features based on client requirements.',
    techStack: ['JavaScript', 'React', 'Node.js', 'SQL'],
  ),
];