import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'add_book_model.dart';
import '../domain/book.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel()..addBook(),
      child: Scaffold(

        appBar: AppBar(
          title: const Text('本を追加'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'タイトル'
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: '著者'
                    ),
                    onChanged: (text) {
                      model.author = text;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: '画像URL'
                    ),
                    onChanged: (text) {
                      model.image = text;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await model.addBook();
                        Navigator.of(context).pop(true);
                      } catch(e) {
                        final failedSnackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString())
                        );
                        ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                      }
                    },
                    child: const Text('追加する'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
