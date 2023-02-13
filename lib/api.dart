import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const String baseUrl = 'https://hacker-news.firebaseio.com/v0';

  static Future<List<int>> getTopStories() async {
    final response = await http.get(Uri.parse('$baseUrl/topstories.json'));
    if (response.statusCode == 200) {
      final List<int> storyIds = jsonDecode(response.body).cast<int>();
      return storyIds;
    } else {
      throw Exception('Failed to fetch top stories');
    }
  }

  static Future<Map<String, dynamic>> getItem(int itemId) async {
    final response = await http.get(Uri.parse('$baseUrl/item/$itemId.json'));
    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      return item;
    } else {
      throw Exception('Failed to fetch item $itemId');
    }
  }

}