import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../widgets/curved_header.dart';
import 'category_detail_screen.dart';
import 'home_screen.dart';

class CategoryScreen extends StatelessWidget {
  final BookService bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori Buku", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF5C4DFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: bookService.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Gagal memuat kategori'));
          }

          final categories = snapshot.data!;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryDetailScreen(
                        category: categories[index].toLowerCase(),
                      ),
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
