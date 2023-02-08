import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen(this.note, this.appBarTitle, {super.key});

  final String appBarTitle;
  final Note note;

  @override
  State<NoteDetailScreen> createState() =>
      NoteDetailScreenState(this.note, this.appBarTitle);
}

class NoteDetailScreenState extends State<NoteDetailScreen> {
  DatabaseHelper helper = DatabaseHelper();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  String date = DateFormat("dd/MM/yyyy").format(DateTime.now());
  String appBarTitle;
  Note note;
  NoteDetailScreenState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    bodyController.text = note.body;

    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5,
      title: Text(appBarTitle),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          _save();
          moveToLastScreen();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever_rounded),
          onPressed: () {
            if (titleController.text.isEmpty && bodyController.text.isEmpty) {
              return;
            } else {
              _delete();
            }
          },
        )
      ],
    );
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(16),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      updateTitle();
                    },
                    maxLines: null,
                    autofocus: true,
                    controller: titleController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Titulo da nota",
                    ),
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      updateBody();
                    },
                    controller: bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Escreva sua nota...",
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_forever_rounded),
        onPressed: () {
          if (titleController.text.isEmpty && bodyController.text.isEmpty) {
            return;
          } else {
            _delete();
          }
        },
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateBody() {
    note.body = bodyController.text;
  }

  void _save() async {
    note.date = DateFormat("dd/MM/yyyy").format(DateTime.now());
    int newId = Random().nextInt(10000);
    int result;
    if (note.id != 0) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      newId = note.id;
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Sua nota foi salva com sucesso!');
    } else {
      // Failure
      _showAlertDialog('Status', 'Houve um problema ao salvar sua nota.');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == 0) {
      _showAlertDialog('Status', 'Não há nenhuma nota para deletar');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = (await helper.deleteNote(note.id));
    if (result != 0) {
      _showAlertDialog('Status', 'Nota deletada com sucesso!');
    } else {
      _showAlertDialog('Status', 'Houve um problema ao deletar sua nota.');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }
}
