import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../providers/theme_provider.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  // Language colors similar to GitHub
  static const Map<String, Color> languageColors = {
    'Python': Color(0xFF3572A5),
    'JavaScript': Color(0xFFF1E05A),
    'TypeScript': Color(0xFF2B7489),
    'HTML': Color(0xFFE34C26),
    'CSS': Color(0xFF563D7C),
    'Dart': Color(0xFF00B4AB),
    'Kotlin': Color(0xFFA97BFF),
    'PHP': Color(0xFF4F5D95),
    'Java': Color(0xFFB07219),
    'C++': Color(0xFFF34B7D),
    'C': Color(0xFF555555),
    'Swift': Color(0xFFFFAC45),
    'Go': Color(0xFF00ADD8),
    'Rust': Color(0xFFDEA584),
    'Ruby': Color(0xFF701516),
  };

  Color _getLanguageColor(String language) {
    return languageColors[language] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleTextColor = isDark ? Colors.white70 : Colors.black54;
    final surfaceColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.white12 : Colors.black12;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? Colors.orange : borderColor,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.orange.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              blurRadius: _isHovered ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.project.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
                const Icon(Icons.code_rounded, color: Colors.orange, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.description,
              style: TextStyle(
                fontSize: 14,
                color: subtleTextColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            // Language percentage bars
            if (widget.project.languages.isNotEmpty) ...[
              _buildLanguageBar(),
              const SizedBox(height: 8),
              _buildLanguageLegend(subtleTextColor),
              const SizedBox(height: 16),
            ],
            // Tech stack tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.techStack.map((tech) => _buildTechTag(tech)).toList(),
            ),
            const SizedBox(height: 20),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.link_rounded,
                    label: 'View Repo',
                    onPressed: () => _launchUrl(widget.project.githubUrl),
                    isPrimary: false,
                    isDark: isDark,
                  ),
                ),
                if (widget.project.liveUrl != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.rocket_launch_rounded,
                      label: 'View Live',
                      onPressed: () => _launchUrl(widget.project.liveUrl!),
                      isPrimary: true,
                      isDark: isDark,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageBar() {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: widget.project.languages.entries.map((entry) {
          return Expanded(
            flex: (entry.value * 10).toInt(),
            child: Container(
              color: _getLanguageColor(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLanguageLegend(Color textColor) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: widget.project.languages.entries.map((entry) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _getLanguageColor(entry.key),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${entry.key} ${entry.value.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 11,
                color: textColor,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Text(
        tech,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.orange,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
    required bool isDark,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isPrimary ? Colors.orange : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.orange,
              width: isPrimary ? 0 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary ? Colors.white : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
