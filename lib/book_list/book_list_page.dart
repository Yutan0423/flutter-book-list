import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../domain/book.dart';
import 'book_list_model.dart';

class BookPageList extends StatelessWidget {
  const BookPageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(

        appBar: AppBar(
          title: const Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
              final List<Book>? books = model.books;
              if (books  == null) {
                return const CircularProgressIndicator();
              }
              final List<Widget> widgets = books.map(
                (book) => ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  leading: Image.network(book.image)
                )
              ).toList();

              return ListView(
                children: widgets
              );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
