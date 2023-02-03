import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notepad/src/data/dummy_data.dart';
import '../models/note.dart';
import '../widgets/note_list_widget.dart';
import 'new_note_screen.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<Note> _note = [];

  _addTransaction(String title, String body, String updatedAt) {
    final newNote = Note(
      id: Random().nextDouble().toString(),
      title: title,
      body: body,
      updatedAt: updatedAt,
    );

    setState(() {
      _note.add(newNote);
    });

    Navigator.of(context).pop();
  }

  _removeNote(String id) {
    setState(() {
      _note.removeWhere((note) => note.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 5,
      scrolledUnderElevation: 5,
      title: const Text('Anotações'),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: _note.map((note) {
                  return NoteListWidget(note);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NewNoteScreen(_addTransaction),
        child: const Icon(Icons.add),
      ),
    );
  }
}
