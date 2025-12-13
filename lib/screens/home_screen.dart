import 'dart:async';
import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import 'detail_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookService _service = BookService();
  final TextEditingController _searchController =
  TextEditingController(text: 'programming');
  Timer? _debounce;

  List<Book> _books = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBooks('programming');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().isNotEmpty) {
        _loadBooks(value.trim());
      }
    });
  }

  Future<void> _loadBooks(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await _service.fetchBooks(query);

    if (!mounted) return;

    setState(() {
      _books = result;
      _isLoading = false;

      if (_books.isEmpty) {
        _error = 'Buku tidak ditemukan';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca Buku Online', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF5C4DFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.category, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CategoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // SEARCH
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF5C4DFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),

          if (_error != null && !_isLoading)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(_error!),
            ),

          if (_books.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return BookCard(
                    book: book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
