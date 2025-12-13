import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  const DetailScreen({required this.book});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final BookService service = BookService();
  late Future<Map<String, dynamic>> futureDetail;

  @override
  void initState() {
    super.initState();
    futureDetail = service.fetchBookDetail(widget.book.workKey!);
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF5C4DFF),
        title: Text(book.title, style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat detail buku'));
          }

          final data = snapshot.data!;
          final description = _getDescription(data);
          final subjects = data['subjects'] as List?;
          final editions = data['revision'];
          final languages = data['languages'] as List?;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// COVER
                if (book.coverUrl.isNotEmpty)
                  Image.network(
                    book.coverUrl,
                    width: double.infinity,
                    height: 260,
                    fit: BoxFit.cover,
                  ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// JUDUL
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      /// PENULIS
                      Text(
                        'Penulis: ${book.author}',
                        style: TextStyle(fontSize: 16),
                      ),

                      if (book.firstPublishYear != null) ...[
                        SizedBox(height: 4),
                        Text('Tahun Terbit Pertama: ${book.firstPublishYear}'),
                      ],

                      Divider(height: 30),

                      /// DESKRIPSI
                      Text(
                        'Deskripsi Buku',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        description ?? 'Deskripsi tidak tersedia.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15),
                      ),

                      Divider(height: 30),

                      /// INFO TAMBAHAN
                      _infoItem('Total Revisi', editions?.toString() ?? 'N/A'),
                      _infoItem(
                        'Bahasa',
                        languages != null
                            ? languages
                                  .map(
                                    (e) => e['key'].toString().replaceAll(
                                      '/languages/',
                                      '',
                                    ),
                                  )
                                  .join(', ')
                            : 'N/A',
                      ),

                      Divider(height: 30),

                      /// SUBJECT
                      Text(
                        'Topik Buku',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      subjects != null
                          ? Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: subjects.take(10).map((s) {
                                return Chip(
                                  label: Text(s.toString()),
                                  backgroundColor: Color(
                                    0xFF5C4DFF,
                                  ).withOpacity(0.15),
                                );
                              }).toList(),
                            )
                          : Text('Topik tidak tersedia'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _getDescription(Map<String, dynamic> data) {
    final desc = data['description'];
    if (desc == null) return null;
    if (desc is String) return desc;
    if (desc is Map && desc['value'] != null) return desc['value'];
    return null;
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
