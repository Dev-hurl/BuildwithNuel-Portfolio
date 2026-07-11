class ProjectModel {
  final String slug;
  final String title;
  final String tagline;
  final String description;
  final String role;
  final List<String> techStack;
  final List<String> screenshotUrls;
  final String challenge;
  final String solution;
  final String? repoUrl;
  final String? demoUrl;

  const ProjectModel({
    required this.slug,
    required this.title,
    required this.tagline,
    required this.description,
    required this.role,
    required this.techStack,
    required this.screenshotUrls,
    required this.challenge,
    required this.solution,
    this.repoUrl,
    this.demoUrl,
  });
}