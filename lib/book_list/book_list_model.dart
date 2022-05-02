import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('books').snapshots();
  List<Book>? books;

  void fetchBookList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String title = data['title'];
        final String author = data['author'];
        final String image = data['image'];
        return Book(title, author, image);
      }).toList();

      this.books = books;
      notifyListeners();
    });


  }
}