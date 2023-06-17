import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/repository.dart';

class ApiService {
  static const String baseUrl = 'https://api.github.com';
  static const String repositoriesKey = 'repositories';

  static Future<List<Repository>> searchRepositories(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl/search/repositories?q=$keyword&sort=stars&order=desc'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> repositories = data['items'];

      // Cache the fetched data locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(repositoriesKey, jsonEncode(repositories));

      return repositories.map((repo) {
        return Repository(
          name: repo['name'],
          description: repo['description'],
          owner: repo['owner']['login'],
          stargazersCount: repo['stargazers_count'],
          lastUpdated: DateTime.parse(repo['updated_at']),
          ownerAvatarUrl: repo['owner']['avatar_url'], // Added ownerAvatarUrl field
        );
      }).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  static Future<List<Repository>> getCachedRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(repositoriesKey);

    if (cachedData != null) {
      final List<dynamic> repositories = jsonDecode(cachedData);

      return repositories.map((repo) {
        return Repository(
          name: repo['name'],
          description: repo['description'],
          owner: repo['owner']['login'],
          stargazersCount: repo['stargazers_count'],
          lastUpdated: DateTime.parse(repo['updated_at']),
          ownerAvatarUrl: repo['owner']['avatar_url'], // Added ownerAvatarUrl field
        );
      }).toList();
    } else {
      return [];
    }
  }
}
