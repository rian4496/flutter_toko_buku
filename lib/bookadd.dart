import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final genreController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  Future<void> _saveBook() async {
    if (_formKey.currentState!.validate()) {
      await DbHelper().insertBook(Book(
        title: titleController.text,
        author: authorController.text,
        genre: genreController.text,
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data buku berhasil disimpan!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Buku"),
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
                  onPressed: _saveBook,
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
