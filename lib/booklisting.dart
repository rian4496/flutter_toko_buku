import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/bookadd.dart';
import 'package:flutter_toko_buku/bookdetail.dart';
import 'package:flutter_toko_buku/bookedit.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class ListBooksPage extends StatefulWidget {
  const ListBooksPage({super.key});

  @override
  State<ListBooksPage> createState() => _ListBooksPageState();
}

class _ListBooksPageState extends State<ListBooksPage> {
  final DbHelper dbHelper = DbHelper();
  List<Book> books = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks({String? query}) async {
    List<Book> bookList = await dbHelper.getBooks(query: query);
    setState(() {
      books = bookList;
    });
  }

  void _deleteBook(int bookId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Book?'),
          content: Text('Are you sure you want to delete this book?'),
          actions: [
            TextButton(
              onPressed: () async {
                await dbHelper.deleteBook(bookId);
                _loadBooks(); // Refresh the list after deletion
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                autofocus: true,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _loadBooks(query: searchController.text);
                },
              )
            : Text("Book List"),
        backgroundColor: Colors.blue.shade300,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          );
          _loadBooks();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadBooks,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber.shade400,
                child: Text("B"),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditBookPage(book: book),
                        ),
                      );
                      _loadBooks();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteBook(book.bookId!);
                    },
                  ),
                ],
              ),
              title: Text(book.title),
              subtitle: Text("${book.author} | ${book.genre}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(book: book),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
