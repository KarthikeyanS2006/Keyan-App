import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleColor = isDark ? Colors.grey : Colors.grey[600];
    final trackColor = isDark ? Colors.white12 : Colors.black12;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            "Skills & Expertise",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 32),
          _buildSkillCategory(context, "Frontend", [
            {"skill": "HTML/CSS", "level": 0.9},
            {"skill": "JavaScript", "level": 0.85},
            {"skill": "Flutter", "level": 0.8},
          ], textColor, subtleColor!, trackColor),
          const SizedBox(height: 24),
          _buildSkillCategory(context, "Backend", [
            {"skill": "PHP", "level": 0.85},
            {"skill": "Python", "level": 0.75},
            {"skill": "Node.js", "level": 0.7},
          ], textColor, subtleColor, trackColor),
          const SizedBox(height: 24),
          _buildSkillCategory(context, "Tools & Mobile", [
            {"skill": "Git", "level": 0.9},
            {"skill": "MySQL", "level": 0.85},
            {"skill": "Firebase", "level": 0.65},
          ], textColor, subtleColor, trackColor),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<Map<String, dynamic>> skills, Color textColor, Color subtleColor, Color trackColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 16),
        ...skills.map((s) => _buildSkillItem(context, s['skill'], s['level'], textColor, subtleColor, trackColor)).toList(),
      ],
    );
  }

  Widget _buildSkillItem(BuildContext context, String skill, double level, Color textColor, Color subtleColor, Color trackColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: TextStyle(fontSize: 14, color: textColor)),
              Text("${(level * 100).toInt()}%", style: TextStyle(fontSize: 12, color: subtleColor)),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: level),
                duration: 1500.ms,
                builder: (context, value, child) {
                  return Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width * value * 0.85,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
