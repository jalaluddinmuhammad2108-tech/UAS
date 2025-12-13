// lib/models/book.dart
class Book {
  final String title;
  final String author;
  final int? coverId;
  final String? workKey;
  final int? firstPublishYear;

  Book({
    required this.title,
    required this.author,
    this.coverId,
    this.workKey,
    this.firstPublishYear,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // Ambil title
    final title = (json['title'] ?? json['work_title'] ?? '').toString();
    // Ambil author dari berbagai kemungkinan struktur
    String author = 'Unknown Author';
    try {
      if (json['author_name'] != null && json['author_name'] is List && (json['author_name'] as List).isNotEmpty) {
        author = (json['author_name'] as List).first.toString();
      } else if (json['authors'] != null && json['authors'] is List && (json['authors'] as List).isNotEmpty) {
        final first = (json['authors'] as List).first;
        if (first is Map && first['name'] != null) {
          author = first['name'].toString();
        } else {
          author = first.toString();
        }
      } else if (json['author'] != null) {
        author = json['author'].toString();
      }
    } catch (_) {
      author = 'Unknown Author';
    }

    // work key
    String? key;
    if (json['key'] != null) {
      key = json['key'].toString();
    } else if (json['work_key'] != null && json['work_key'] is List && (json['work_key'] as List).isNotEmpty) {
      key = (json['work_key'] as List).first.toString();
    }

    // cover id
    int? coverId;
    try {
      if (json['cover_i'] != null) {
        coverId = (json['cover_i'] as num).toInt();
      } else if (json['cover_id'] != null) {
        coverId = (json['cover_id'] as num).toInt();
      }
    } catch (_) {
      coverId = null;
    }

    // first publish year
    int? firstYear;
    try {
      if (json['first_publish_year'] != null) {
        firstYear = (json['first_publish_year'] as num).toInt();
      }
    } catch (_) {
      firstYear = null;
    }

    return Book(
      title: title.isEmpty ? 'No Title' : title,
      author: author,
      coverId: coverId,
      workKey: key,
      firstPublishYear: firstYear,
    );
  }

  String get coverUrl {
    if (coverId == null) return '';
    return 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';
  }
}
