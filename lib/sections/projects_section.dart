import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../providers/theme_provider.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

  final List<Project> projects = [
    Project(
      title: "SGAC-COLLEGE-WEBSITE-",
      description: "A comprehensive college website built for SGAC.",
      githubUrl: "https://github.com/KarthikeyanS2006/SGAC-COLLEGE-WEBSITE-",
      liveUrl: "https://karthikeyans2006.github.io/SGAC-COLLEGE-WEBSITE-/",
      techStack: ["HTML", "CSS", "JS"],
      languages: {"HTML": 52.3, "CSS": 35.1, "JavaScript": 12.6},
    ),
    Project(
      title: "Crystalize_AI",
      description: "Advanced AI application with modern interface.",
      githubUrl: "https://github.com/KarthikeyanS2006/Crystalize_AI",
      liveUrl: "https://dd-ebon-beta.vercel.app",
      techStack: ["Next.js", "AI", "Tailwind"],
      languages: {"TypeScript": 68.2, "CSS": 18.5, "JavaScript": 13.3},
    ),
    Project(
      title: "Voice_assistant-llm",
      description: "Local LLM model voice assistant.",
      githubUrl: "https://github.com/KarthikeyanS2006/Voice_assistant-llm",
      techStack: ["Python", "LLM", "Speech Recognition"],
      languages: {"Python": 100.0},
    ),
    Project(
      title: "ANDROID_ADAS",
      description: "Advanced Driver Assistance System for Android.",
      githubUrl: "https://github.com/KarthikeyanS2006/ANDROID_ADAS",
      techStack: ["Flutter", "Kotlin", "Mediapipe"],
      languages: {"Dart": 45.8, "Python": 32.4, "Kotlin": 21.8},
    ),
    Project(
      title: "keyan-code-python-",
      description: "A browser-based Python IDE for quick coding.",
      githubUrl: "https://github.com/KarthikeyanS2006/keyan-code-python-",
      techStack: ["Python", "Web"],
      languages: {"Python": 78.5, "HTML": 15.2, "CSS": 6.3},
    ),
    Project(
      title: "Student-Report-Card-System",
      description: "System to manage student academic records.",
      githubUrl: "https://github.com/KarthikeyanS2006/Student-Report-Card-System",
      techStack: ["PHP", "MySQL", "Bootstrap"],
      languages: {"PHP": 55.2, "HTML": 28.4, "CSS": 10.1, "JavaScript": 6.3},
    ),
  ];

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
            "A collection of my recent works across web and mobile development.",
            style: TextStyle(color: subtleColor),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index])
                  .animate()
                  .fadeIn(delay: (400 + (index * 100)).ms)
                  .slideY(begin: 0.1);
            },
          ),
        ],
      ),
    );
  }
}
