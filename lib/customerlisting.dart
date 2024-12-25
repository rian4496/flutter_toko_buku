import 'package:flutter/material.dart';
import 'package:flutter_toko_buku/customeradd.dart';
import 'package:flutter_toko_buku/customerdetail.dart';
import 'package:flutter_toko_buku/customeredit.dart';
import 'package:flutter_toko_buku/dbhelper.dart';

class ListCustomerPage extends StatefulWidget {
  const ListCustomerPage({super.key});

  @override
  State<ListCustomerPage> createState() => _ListCustomerPageState();
}

class _ListCustomerPageState extends State<ListCustomerPage> {
  final DbHelper dbHelper = DbHelper();
  List<Customer> customers = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers({String? query}) async {
    List<Customer> customerList = await dbHelper.getCustomers(query: query);
    setState(() {
      customers = customerList;
    });
  }

  void _deleteCustomer(int customerId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Customer?'),
          content: Text('Are you sure you want to delete this customer?'),
          actions: [
            TextButton(
              onPressed: () async {
                await dbHelper.deleteCustomer(customerId);
                _loadCustomers(); // Refresh the list after deletion
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
                  _loadCustomers(query: searchController.text);
                },
              )
            : Text("Customer List"),
        backgroundColor: Colors.orange.shade300,
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
            MaterialPageRoute(builder: (context) => AddCustomerPage()),
          );
          _loadCustomers();
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadCustomers,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade400,
                child: Text("C"),
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
                          builder: (context) =>
                              EditCustomerPage(customer: customer),
                        ),
                      );
                      _loadCustomers();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteCustomer(customer.customerId!);
                    },
                  ),
                ],
              ),
              title: Text(customer.name),
              subtitle: Text("${customer.email} | ${customer.phone}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CustomerDetailPage(customer: customer),
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
