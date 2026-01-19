import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/hover_button.dart';

class IntroSection extends StatelessWidget {
  final VoidCallback? onNavigateToProjects;
  final VoidCallback? onNavigateToContact;

  const IntroSection({
    super.key,
    this.onNavigateToProjects,
    this.onNavigateToContact,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleTextColor = isDark ? Colors.white70 : Colors.black54;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          // Profile Photo
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/image.png',
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 32),
          // Greeting
          Text(
            "Hello, I'm",
            style: TextStyle(
              fontSize: 22,
              color: Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
          const SizedBox(height: 4),
          // Name
          Text(
            "Karthikeyan",
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.1),
          const SizedBox(height: 8),
          // Title
          Text(
            "Full Stack Developer",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.orange,
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.1),
          const SizedBox(height: 24),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "I build modern web and mobile applications using the latest technologies. Passionate about creating seamless user experiences and solving complex problems.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: subtleTextColor,
              ),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
          const SizedBox(height: 40),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HoverButton(
                text: 'View My Work',
                isPrimary: true,
                onPressed: onNavigateToProjects,
                icon: Icons.work_rounded,
              ),
              const SizedBox(width: 16),
              HoverButton(
                text: 'Contact Me',
                isPrimary: false,
                onPressed: onNavigateToContact,
                icon: Icons.mail_rounded,
              ),
            ],
          ).animate().fadeIn(duration: 500.ms, delay: 800.ms).slideY(begin: 0.1),
          const SizedBox(height: 40),
          // Social links hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.code_rounded, isDark),
              const SizedBox(width: 24),
              _buildSocialIcon(Icons.link_rounded, isDark),
              const SizedBox(width: 24),
              _buildSocialIcon(Icons.email_rounded, isDark),
            ],
          ).animate().fadeIn(duration: 500.ms, delay: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Icon(
        icon,
        color: Colors.orange,
        size: 22,
      ),
    );
  }
}
