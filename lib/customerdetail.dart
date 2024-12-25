import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class CustomerDetailPage extends StatelessWidget {
  final Customer customer;
  const CustomerDetailPage({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(customer.name),
        centerTitle: true,
        backgroundColor: Colors.orange.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name : " + customer.name),
            SizedBox(height: 10),
            Text("Email : " + customer.email),
            SizedBox(height: 10),
            Text("Phone : " + customer.phone),
            SizedBox(height: 10),
            Text("Address : " + customer.address),
            SizedBox(height: 10),
            Text("Registered : " + customer.registrationDate),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
