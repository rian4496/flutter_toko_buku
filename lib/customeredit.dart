import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class EditCustomerPage extends StatefulWidget {
  final Customer customer; // Buat objek dari class Customer
  const EditCustomerPage(
      {required this.customer}); // Menerima nilai dari list/customer list

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var registrationDateController = TextEditingController();

  Future<void> _updateCustomer() async {
    if (_formKey.currentState!.validate()) {
      await DbHelper().updateCustomer(Customer(
        customerId: widget.customer.customerId, // Tetap gunakan ID customer
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        registrationDate: registrationDateController.text,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data customer berhasil diperbaharui!")));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customer.name);
    emailController = TextEditingController(text: widget.customer.email);
    phoneController = TextEditingController(text: widget.customer.phone);
    addressController = TextEditingController(text: widget.customer.address);
    registrationDateController =
        TextEditingController(text: widget.customer.registrationDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Customer'),
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
                  onPressed: _updateCustomer,
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
