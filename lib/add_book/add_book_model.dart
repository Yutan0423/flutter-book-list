import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;
  String? image;

  Future addBook() async {
    if(title == null || title == '') {
      throw '本のタイトルが入力されていません。';
    }
    if(author == null || author == '') {
      throw '本の著者名が入力されていません。';
    }
    if(image == null || image == '') {
      throw '本の画像URLが入力されていません。';
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
      'image': image
    });
  }
}