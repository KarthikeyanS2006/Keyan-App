import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleTextColor = isDark ? Colors.white70 : Colors.black54;
    final surfaceColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.white10 : Colors.black12;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            "About Me",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 24),
          Text(
            "I am a passionate Full Stack Developer pursuing a BCA (Bachelor of Computer Applications). I specialize in PHP, JavaScript, and Flutter, with a strong interest in building scalable and user-friendly solutions.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: subtleTextColor,
            ),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 32),
          _buildGitHubStats(context, surfaceColor, borderColor, textColor).animate().fadeIn(delay: 400.ms).scale(),
          const SizedBox(height: 32),
          Text(
            "Socials",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn(delay: 600.ms),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSocialIcon(
                context,
                Icons.code_rounded,
                "GitHub",
                "https://github.com/KarthikeyanS2006",
                isDark,
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                context,
                Icons.language_rounded,
                "Website",
                "https://karthikeyans2006.github.io/",
                isDark,
              ),
            ],
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }

  Widget _buildGitHubStats(BuildContext context, Color surfaceColor, Color borderColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("25", "Repositories", textColor),
          _buildStatItem("2", "Followers", textColor),
          _buildStatItem("0", "Following", textColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String label, String url, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
