import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/github_service.dart';
import '../services/notification_service.dart';

class GitHubActivityBanner extends StatefulWidget {
  const GitHubActivityBanner({super.key});

  @override
  State<GitHubActivityBanner> createState() => _GitHubActivityBannerState();
}

class _GitHubActivityBannerState extends State<GitHubActivityBanner> {
  List<GitHubEvent> _events = [];
  bool _isLoading = true;
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final events = await GitHubService.getUserRecentPushes();
    if (mounted) {
      if (events.isNotEmpty) {
        final latestEvent = events.first;
        final prefs = await SharedPreferences.getInstance();
        final lastNotifiedTime = prefs.getInt('last_notified_event_time') ?? 0;
        
        // Show system notification if it's a new event we haven't notified about yet
        if (latestEvent.createdAt.millisecondsSinceEpoch > lastNotifiedTime) {
          await NotificationService.showNotification(
            id: latestEvent.createdAt.millisecondsSinceEpoch ~/ 1000,
            title: 'New GitHub Activity! 🚀',
            body: '${latestEvent.repoName}: ${latestEvent.commitMessage ?? "New push"}',
            payload: 'https://github.com/KarthikeyanS2006/${latestEvent.repoName}',
          );
          await prefs.setInt('last_notified_event_time', latestEvent.createdAt.millisecondsSinceEpoch);
        }
      }

      setState(() {
        _events = events;
        _isLoading = false;
        _showBanner = events.isNotEmpty;
      });

      // Auto-hide banner after 8 seconds
      if (events.isNotEmpty) {
        Future.delayed(const Duration(seconds: 8), () {
          if (mounted) {
            setState(() => _showBanner = false);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || !_showBanner || _events.isEmpty) {
      return const SizedBox.shrink();
    }

    final latestEvent = _events.first;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: GestureDetector(
        onTap: () => setState(() => _showBanner = false),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.9),
                Colors.deepOrange.withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'New GitHub Activity! 🚀',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${latestEvent.repoName} • ${latestEvent.timeAgo}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                    if (latestEvent.commitMessage != null)
                      Text(
                        latestEvent.commitMessage!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => setState(() => _showBanner = false),
                icon: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: -1, end: 0, curve: Curves.easeOutBack),
      ),
    );
  }
}
