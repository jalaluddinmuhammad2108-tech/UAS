import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import 'detail_screen.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final BookService _service = BookService();

  CategoryDetailScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF5C4DFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

      ),
      body: FutureBuilder<List<Book>>(
        future: _service.fetchBooksByCategory(category.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat buku: ${snapshot.error}'));
          }
          final books = snapshot.data ?? [];
          if (books.isEmpty) {
            return const Center(child: Text('Tidak ada buku di kategori ini'));
          }

          // Gunakan ListView.builder secara langsung untuk mencegah overflow
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final b = books[index];
              return BookCard(
                book: b,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(book: b),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
