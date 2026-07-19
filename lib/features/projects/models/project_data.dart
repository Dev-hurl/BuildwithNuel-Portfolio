import 'project_model.dart';

final List<ProjectModel> projects = [
  ProjectModel(
    slug: 'orbitask',
    title: 'OrbiTask : Task Management App',
    tagline:
        'A task management app, built as both a learning project and a portfolio piece.',
    description:
        'TODO: 2-3 sentences on the problem OrbiTask solves for its user.',
    role: 'Solo Developer & UX/UI Designer',
    techStack: ['Flutter', 'Provider', 'Firebase', 'Figma'],
    screenshotUrls: [
      'assets/images/orbitask.jpg',
      'assets/images/orbitask screenshot.jpg',
    ],
    challenge:
        'TODO: e.g. building the two-stage splash animation with chained AnimationControllers',
    solution:
        'OrbiTask is designed to help students, professionals, and business owners overcome the challenges of  poor time and task management. The app provides a structured approach by integrating smart  reminders, personalized scheduling, and progress tracking to enhance productivity. Through features  that prioritize tasks, reduce procrastination, and promote consistency, OrbiTask ensures users can  efficiently manage their workload and achieve their goals.',
    repoUrl: 'https://github.com/Dev-hurl/OrbiTask',
    demoUrl: '',
  ),
  ProjectModel(
    slug: 'swift-mart',
    title: 'SwiftMart',
    tagline: 'E-commerce app for first-time users',
    description:
        'SwiftMart is a modern e-commerce app designed to make online shopping seamless, especially for first-time users. The project emphasizes ease of use, fast onboarding, and a smooth guest checkout experience. ',
    role: 'Developer & UX/UI Designer',
    techStack: ['Flutter', 'Figma', 'Chatgpt'],
    screenshotUrls: [
      'assets/images/swiftmart.jpg',
      'assets/images/swiftmart screenshot.jpg',
    ],
    challenge:
        'Traditional e-commerce platforms lose new users due to onboarding and checkout friction. Complex forms, mandatory account creation, and tedious steps trigger high cart abandonment and cognitive overload for first-time shoppers.',
    solution:
        'SwiftMart removes these barriers with a frictionless, user-first shopping journey. It features a fast, welcoming onboarding experience, a seamless guest checkout option, and an intuitive UI that guides beginners effortlessly from product discovery to final purchase.',
    repoUrl: 'https://github.com/Dev-hurl/swift_mart',
    demoUrl: '',
  ),
  ProjectModel(
    slug: 'job-board',
    title: 'Job Board App',
    tagline: 'TODO',
    description: 'TODO',
    role: 'Solo Developer',
    techStack: ['Flutter',],
    screenshotUrls: [],
    challenge: 'TODO',
    solution: 'TODO',
    repoUrl: null,
    demoUrl: null,
  ),
];
