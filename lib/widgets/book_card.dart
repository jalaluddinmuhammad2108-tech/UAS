import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCard({Key? key, required this.book, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cover = book.coverUrl;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 68,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  image: cover.isNotEmpty
                      ? DecorationImage(image: NetworkImage(cover), fit: BoxFit.cover)
                      : null,
                ),
                child: cover.isEmpty ? const Icon(Icons.book, size: 36, color: Colors.grey) : null,
              ),
              const SizedBox(width: 12),

              // title & author
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (book.firstPublishYear != null)
                          Text(
                            '${book.firstPublishYear}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        const Spacer(),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(color: const Color(0xFF5C4DFF), shape: BoxShape.circle),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
