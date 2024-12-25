import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Model for Book
class Book {
  final int? bookId;
  final String title;
  final String author;
  final String genre;
  final double price;
  final int stock;

  Book({
    this.bookId,
    required this.title,
    required this.author,
    required this.genre,
    required this.price,
    required this.stock,
  });

  // Convert from Map (Database) to Book Object
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      bookId: map['book_id'],
      title: map['title'],
      author: map['author'],
      genre: map['genre'],
      price: map['price'],
      stock: map['stock'],
    );
  }

  // Convert from Book Object to Map (Database)
  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'title': title,
      'author': author,
      'genre': genre,
      'price': price,
      'stock': stock,
    };
  }
}

// Model for Customer
class Customer {
  final int? customerId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String registrationDate;

  Customer({
    this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.registrationDate,
  });

  // Convert from Map (Database) to Customer Object
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerId: map['customer_id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      registrationDate: map['registration_date'],
    );
  }

  // Convert from Customer Object to Map (Database)
  Map<String, dynamic> toMap() {
    return {
      'customer_id': customerId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'registration_date': registrationDate,
    };
  }
}

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  DbHelper._internal();

  factory DbHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bookstore.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create books table
        await db.execute('''
          CREATE TABLE books (
            book_id INTEGER PRIMARY KEY,
            title TEXT,
            author TEXT,
            genre TEXT,
            price REAL,
            stock INTEGER
          )
        ''');

        // Create customers table
        await db.execute('''
          CREATE TABLE customers (
            customer_id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            phone TEXT,
            address TEXT,
            registration_date TEXT
          )
        ''');
      },
    );
  }

  // CRUD for Books
  Future<List<Book>> getBooks({String? query}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;
    if (query != null && query.isNotEmpty) {
      maps = await db
          .query("books", where: "title LIKE ?", whereArgs: ['%$query%']);
    } else {
      maps = await db.query("books");
    }
    return maps.map((map) => Book.fromMap(map)).toList();
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    return await db.insert("books", book.toMap());
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    return await db.update(
      "books",
      book.toMap(),
      where: "book_id = ?",
      whereArgs: [book.bookId],
    );
  }

  Future<int> deleteBook(int bookId) async {
    final db = await database;
    return await db.delete("books", where: "book_id = ?", whereArgs: [bookId]);
  }

  // CRUD for Customers
  Future<List<Customer>> getCustomers({String? query}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps;
    if (query != null && query.isNotEmpty) {
      maps = await db
          .query("customers", where: "name LIKE ?", whereArgs: ['%$query%']);
    } else {
      maps = await db.query("customers");
    }
    return maps.map((map) => Customer.fromMap(map)).toList();
  }

  Future<int> insertCustomer(Customer customer) async {
    final db = await database;
    return await db.insert("customers", customer.toMap());
  }

  Future<int> updateCustomer(Customer customer) async {
    final db = await database;
    return await db.update(
      "customers",
      customer.toMap(),
      where: "customer_id = ?",
      whereArgs: [customer.customerId],
    );
  }

  Future<int> deleteCustomer(int customerId) async {
    final db = await database;
    return await db
        .delete("customers", where: "customer_id = ?", whereArgs: [customerId]);
  }
}
