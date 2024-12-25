import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final registrationDateController = TextEditingController();

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      await DbHelper().insertCustomer(Customer(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        registrationDate: registrationDateController.text,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data customer berhasil disimpan!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Customer"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? "Nama harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? "Email harus diisi" : null,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                validator: (value) =>
                    value!.isEmpty ? "Nomor Telepon harus diisi" : null,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                validator: (value) =>
                    value!.isEmpty ? "Alamat harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: registrationDateController,
                validator: (value) =>
                    value!.isEmpty ? "Tanggal Registrasi harus diisi" : null,
                decoration: InputDecoration(
                  labelText: "Tanggal Registrasi",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveCustomer,
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
