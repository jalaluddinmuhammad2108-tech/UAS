import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  static const int _limit = 30;

  Future<List<Book>> fetchBooks(String query) async {
    try {
      final uri = Uri.parse(
        'https://openlibrary.org/search.json'
        '?q=${Uri.encodeQueryComponent(query)}'
        '&limit=$_limit',
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return [];
      }

      final data = json.decode(response.body);
      final List docs = data['docs'] ?? [];

      return docs.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Book>> fetchBooksByCategory(String category) async {
    try {
      final uri = Uri.parse(
        'https://openlibrary.org/subjects/${category.toLowerCase()}.json?limit=$_limit',
      );

      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) return [];

      final jsonData = json.decode(response.body);
      final List works = jsonData['works'] ?? [];

      return works.map((e) => Book.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchBookDetail(String workKey) async {
    final response = await http.get(
      Uri.parse('https://openlibrary.org$workKey.json'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat detail buku');
    }
  }

  Future<List<String>> fetchCategories() async {
    // daftar subject diambil dari API subjects yang valid
    final subjects = [
      'programming',
      'science',
      'history',
      'fantasy',
      'religion',
      'education',
    ];

    List<String> available = [];

    for (String s in subjects) {
      final res = await http.get(
        Uri.parse('https://openlibrary.org/subjects/$s.json?limit=1'),
      );

      if (res.statusCode == 200) {
        available.add(s[0].toUpperCase() + s.substring(1));
      }
    }

    return available;
  }
}
