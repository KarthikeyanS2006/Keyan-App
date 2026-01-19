import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  static const String _baseUrl = 'https://api.github.com';
  static const String _username = 'KarthikeyanS2006';

  // Fetch repository languages with percentages
  static Future<Map<String, double>> getRepoLanguages(String repoName) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/repos/$_username/$repoName/languages'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final int total = data.values.fold(0, (sum, val) => sum + (val as int));
        
        return data.map((key, value) => 
          MapEntry(key, ((value as int) / total * 100).roundToDouble())
        );
      }
    } catch (e) {
      print('Error fetching languages: $e');
    }
    return {};
  }

  // Fetch recent events for a repository
  static Future<List<GitHubEvent>> getRepoEvents(String repoName) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/repos/$_username/$repoName/events'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.take(5).map((e) => GitHubEvent.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
    return [];
  }

  // Fetch user's recent push events across all repos
  static Future<List<GitHubEvent>> getUserRecentPushes() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$_username/events'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .where((e) => e['type'] == 'PushEvent')
            .take(10)
            .map((e) => GitHubEvent.fromJson(e))
            .toList();
      }
    } catch (e) {
      print('Error fetching user events: $e');
    }
    return [];
  }

  // Get last push time for a repository
  static Future<DateTime?> getLastPushTime(String repoName) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/repos/$_username/$repoName'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return DateTime.parse(data['pushed_at']);
      }
    } catch (e) {
      print('Error fetching repo info: $e');
    }
    return null;
  }
}

class GitHubEvent {
  final String type;
  final String repoName;
  final DateTime createdAt;
  final String? commitMessage;

  GitHubEvent({
    required this.type,
    required this.repoName,
    required this.createdAt,
    this.commitMessage,
  });

  factory GitHubEvent.fromJson(Map<String, dynamic> json) {
    String? message;
    if (json['type'] == 'PushEvent' && json['payload']?['commits'] != null) {
      final commits = json['payload']['commits'] as List;
      if (commits.isNotEmpty) {
        message = commits.first['message'];
      }
    }

    return GitHubEvent(
      type: json['type'] ?? 'Unknown',
      repoName: json['repo']?['name']?.split('/')?.last ?? 'Unknown',
      createdAt: DateTime.parse(json['created_at']),
      commitMessage: message,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
