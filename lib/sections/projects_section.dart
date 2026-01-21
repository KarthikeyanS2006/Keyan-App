import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../services/github_service.dart';
import '../models/project.dart';
import '../providers/theme_provider.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _fetchProjects();
  }

  Future<List<Project>> _fetchProjects() async {
    final repos = await GitHubService.getRepositories();
    final List<Project> projects = [];

    for (var repo in repos) {
      // Fetch languages for each repo
      final languages = await GitHubService.getRepoLanguages(repo['name']);
      
      projects.add(Project(
        title: repo['name'],
        description: repo['description'] ?? "No description available.",
        githubUrl: repo['html_url'],
        liveUrl: repo['homepage'],
        techStack: [repo['language'] ?? 'Other'],
        languages: languages,
      ));
    }
    return projects;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleColor = isDark ? Colors.grey : Colors.grey[600];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            "My Projects",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 8),
          Text(
            "A collection of my recent works fetched directly from GitHub.",
            style: TextStyle(color: subtleColor),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 32),
          FutureBuilder<List<Project>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(color: Colors.orange),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: textColor)));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No projects found.', style: TextStyle(color: textColor)));
              }

              final projects = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(project: projects[index])
                      .animate()
                      .fadeIn(delay: (200 + (index * 50)).ms)
                      .slideY(begin: 0.1);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
