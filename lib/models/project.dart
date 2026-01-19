class Project {
  final String title;
  final String description;
  final String githubUrl;
  final String? liveUrl;
  final List<String> techStack;
  final Map<String, double> languages; // Language name -> percentage

  Project({
    required this.title,
    required this.description,
    required this.githubUrl,
    this.liveUrl,
    required this.techStack,
    this.languages = const {},
  });

  // Get repo name from GitHub URL
  String get repoName {
    final uri = Uri.parse(githubUrl);
    final segments = uri.pathSegments;
    return segments.isNotEmpty ? segments.last : title;
  }
}
