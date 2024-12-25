import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  const BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title : " + book.title),
            SizedBox(height: 10),
            Text("Author : " + book.author),
            SizedBox(height: 10),
            Text("Genre : " + book.genre),
            SizedBox(height: 10),
            Text("Price : \$" + book.price.toStringAsFixed(2)),
            SizedBox(height: 10),
            Text("Stock : " + book.stock.toString()),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
