import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class EditBookPage extends StatefulWidget {
  final Book book; // Buat objek dari class Book
  const EditBookPage(
      {required this.book}); // Menerima nilai dari list/book list

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var authorController = TextEditingController();
  var genreController = TextEditingController();
  var priceController = TextEditingController();
  var stockController = TextEditingController();

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      await DbHelper().updateBook(Book(
        bookId: widget.book.bookId, // Tetap gunakan ID buku
        title: titleController.text,
        author: authorController.text,
        genre: genreController.text,
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data buku berhasil diperbaharui!")));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    genreController = TextEditingController(text: widget.book.genre);
    priceController = TextEditingController(text: widget.book.price.toString());
    stockController = TextEditingController(text: widget.book.stock.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Buku'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) =>
                    value!.isEmpty ? "Judul buku harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Judul Buku",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: authorController,
                validator: (value) =>
                    value!.isEmpty ? "Penulis harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Penulis",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: genreController,
                validator: (value) =>
                    value!.isEmpty ? "Genre harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Genre",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                validator: (value) =>
                    value!.isEmpty ? "Harga harus diisi" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: stockController,
                validator: (value) =>
                    value!.isEmpty ? "Stok harus diisi" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Stok",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _updateBook,
                  child: Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
