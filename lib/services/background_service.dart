import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'github_service.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 1. Check for new Repo Activity
      final events = await GitHubService.getUserRecentPushes();
      if (events.isNotEmpty) {
        final latestEvent = events.first;
        final lastNotifiedTime = prefs.getInt('last_notified_event_time') ?? 0;
        
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

      // 2. Check for New Repositories
      final repos = await GitHubService.getRepositories();
      final lastRepoCount = prefs.getInt('last_repo_count') ?? repos.length;
      
      if (repos.length > lastRepoCount) {
        // Sort by created_at to find the latest
        repos.sort((a, b) => DateTime.parse(b['created_at']).compareTo(DateTime.parse(a['created_at'])));
        final newRepo = repos.first;
        
        await NotificationService.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: 'New Project Launched! ✨',
          body: 'Created: ${newRepo['name']}\n${newRepo['description'] ?? "No description"}',
          payload: newRepo['html_url'],
        );
      }
      
      await prefs.setInt('last_repo_count', repos.length);

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}
